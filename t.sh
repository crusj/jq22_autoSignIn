#! /bin/bash

em=$1
pw=$2
path=$3
echo "账号${em}正在登录..."
curl  -d "em=${em}&pw=${pw}" -c "${path}/cookie" "http://www.jq22.com/emdl.aspx" > /dev/null
#然后再进入jquery主页，单上上一步返回的cookie
curl  -b "${path}/cookie" "http://www.jq22.com" > /dev/null
#进入个人主页
curl  -b "${path}/cookie" -c "${path}/cookie" "http://www.jq22.com/myhome" > /dev/null
#签到页面
curl  -b "${path}/cookie" "http://www.jq22.com/signIn.aspx" > ${path}/signIn
#获取表单信息
awk '/hidden/' ${path}/signIn | sed 's/.*name="\([^"]*\)".*value="\([^"]*\).*/\1=\2/' >> ${path}/form
#拼接表单信息
while read tmp
do
if [ $value ];then
	value="${value}&${tmp}"
else
	value=$tmp
fi
done < ${path}/form
#进行签到
value=$(echo $value | sed -e 's/\//%2F/g' -e 's/\+/%2B/g')
value="${value}&Button1=%E7%AD%BE%E5%88%B0%0A"
curl  -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36" -d $value -e "http://www.jq22.com" -b "${path}/cookie"  "http://www.jq22.com/signIn.aspx" > /dev/null
echo "账号${em}正在签到...."
echo "${em}签到完成"
echo "${em}进行了签到" >> "${path}/signIn.log"
rm ${path}/form ${path}/signIn ${path}/cookie
