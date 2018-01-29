#! /bin/bash
#当前脚本所在目录
path=$(cd `dirname $0`;pwd)
#当前时间
current_date=$(date "+%Y-%m-%d %H:%M:%S")
#判断账号文件是否存在
if [ ! -f "$path/account" ];then
	echo "账号文件${path}/account不存在"
	exit	
fi
echo "=====================${current_date}签到日志" >> "$path/signIn.log"
while read name password
do
	${path}/t.sh $name $password $path
done < ${path}/account
