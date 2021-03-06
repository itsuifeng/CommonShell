#!/bin/bash

###############
# Name: 选择菜单
# Author: ZhangTianJie
# Email: ztj1993@gmail.com
# Use: curl -sSL http://dwz.cn/tJvCyBGb > /tmp/SelectMenu && source /tmp/SelectMenu
# Params: <Title ItemArray ItemArray...>(ArrayString)
# Returns: 0:skip-quit   1-254:index   255:error
###############

### 定义帮助文本
if [ "${1}" == "help" ]; then
    echo ">>> Params <Title ItemArray ItemArray...>(ArrayString)"
    exit 0
fi

### 设置变量
if [ "${SelectMenuItems}" == "" ]; then
    args=("${@}")
    SelectMenuTitle=${args[0]}
    SelectMenuItems=("${args[@]:1}")
    [ "${SelectMenuTitle}" == "-" ] && SelectMenuTitle=""
fi
[ "${SelectMenuItems}" == "" ] && echo ">>>>> Error: SelectMenuItems var do not exist" && exit 255
SelectMenuTitle=${SelectMenuTitle:-"Please select menu"}

### 显示提示
echo "----- ${SelectMenuTitle} -----"
echo " 0) skip-quit"
for Index in ${!SelectMenuItems[@]}
do
    echo " $[${Index}+1]) ${SelectMenuItems[${Index}]}"
done

### 设置并获取选择的菜单项
read -p "Please enter index：" SelectMenuIndex
SelectMenuItem="${SelectMenuItems[$[${SelectMenuIndex}-1]]}"
echo "you have selected the: ${SelectMenuItem}"

### 输出返回值
[ ${#args[*]} != 0 ] && exit ${SelectMenuIndex}
