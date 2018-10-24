简单模板引擎脚本使用文档 (TplEngine)
======

### 说明
- 这个模板引擎目标在于解决 nginx systemd 等配置文件的生成，主要为实现变量替换和判断语句的处理。
- 脚本实现的及其轻量，因此也有诸多限制。

### 脚本功能实现
- 实现了简单变量的替换和判断
- 实现了常规语句的执行
- 实现了引号处理
- 实现了模板中带有其他变量的处理

### 模板标签使用方法
- 语句请用```<{=``` 和 ```=}>``` 包含起来
  - 注意：```<{=``` 必须位于行的开头
- 变量请用```<%=``` 和 ```=%>``` 包含起来
  - 注意：`语句内的变量就不要在包含了

### 使用示例
tpl.tpl 模板文件
```
# tpl.tpl 模板文件
server {
    listen 80;
<{=if [ "${ServerAlias}" == "" ]; then=}>
    server_name <%=${ServerName}=%>;
<{=else=}>
    server_name <%=${ServerName}=%> <%=${ServerAlias}=%>;
<{=fi=}>
    if ($scheme = "http") {
        return 301 https://$host$request_uri;
    }
    ssl_certificate /data/configs/ertificate/<%=${SslSign}=%>.crt;
    ssl_certificate_key /data/configs/ertificate/<%=${SslSign}=%>.key;
}
```
test.sh 测试脚本
```
#!/bin/bash

# test.sh 测试脚本

### 设置模板内容
TplContent=`cat ./tpl.tpl`

### 设置模板变量
ServerAlias=""
ServerName="ztj1993"
SslSign="ztj"

source /data/shell/source/tpl.sh

echo "${TplContent}" > tpl.conf
```
执行 ./test.sh 即可查看效果。
