# UbuntuChatRoom

This is a simple chatRoom used on ubuntu!

## Download

Download the code from this here, unnzip UbuntuChatRoom-master.zip and put all the content in ~/ directly.

Files structure like:

```
\home\USER_NAME\--chat.sh
		|-chatRoom\--xxx
			   |-xxx
			   |-...
```

## Usage

All users should log in one same Ubuntu locally or remotely by ssh. 

Then type ```./chat.sh``` to start our chat script.....

Your nickname will by asked, so no one knows your real identity.

Just enjoy it!

## Warning

The script relys on shell command ```who am i``` on ubuntu. If your ubuntu return nothing for  ```who am i```, it will not work very well on your ubuntu. 