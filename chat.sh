#! /bin/bash -i

##用户名设置
# 检查当前用户是否设置过用户名
curTag=$(who am i |  awk '{$1=$1;print}') #去除多余空格 
echo 当前终端是：$curTag
curTag=$(echo $curTag | awk '{print $1"_"$2"_"$3"_"$4"_"$5}') 
grep $curTag ~/chatRoom/userRegister > /dev/null

if  [ $? -gt 0 ];then  #找不到曾用名，新建并存入
	read -p "请输入你的聊天昵称: " username
	echo $curTag $username >> ~/chatRoom/userRegister
else 		       #找到曾用名
	username=$( grep $curTag ~/chatRoom/userRegister | awk '{print $2}')
fi

##房间选择
echo "当前已存在的聊天房："
cat ~/chatRoom/roomRegister
echo "请选择或创建聊天房间，输入房号（数字）："
read roomNumber
grep room$roomNumber ~/chatRoom/roomRegister > /dev/null
if  [ $? -gt 0 ];then  #创建新房间
	echo room$roomNumber >> ~/chatRoom/roomRegister
fi

echo $username 进入聊天室 >> ~/chatRoom/chatContent$roomNumber
trap "echo $username 离开聊天室 >> ~/chatRoom/chatContent$roomNumber" EXIT #退出聊天室时发送退出消息

##在房间中聊天

msg=""
while true
do 
	clear
	echo -e "\e[32m\e[1mcurrent chatRoom: room$roomNumber \e[0m "
	tail -n 20  ~/chatRoom/chatContent$roomNumber
	echo -n -e "\e[32m\e[1mEnter Message:\e[0m " $msg 
	read -t 10 nmsg
	if [ $? -gt 0 ];then
		read nmsg <<< $(echo -e "\n")
		msg=$msg$nmsg
		#echo “此次循环未按下Enter，msg=$msg，nmsg=$nmsg”
		sleep 3
	else
		msg=$msg$nmsg
		echo [ $(date "+%H:%M:%S") ] [ $username ]: $msg >> ~/chatRoom/chatContent$roomNumber
		msg=""
	fi
done

