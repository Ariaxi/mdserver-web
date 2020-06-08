#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


curPath=`pwd`
rootPath=$(dirname "$curPath")
rootPath=$(dirname "$rootPath")
serverPath=$(dirname "$rootPath")


install_tmp=${rootPath}/tmp/mw_install.pl

SYSOS=`uname`

Install_v2ray()
{
	isStart=""
	echo '正在安装脚本文件...' > $install_tmp
	mkdir -p $serverPath/v2ray
	echo '1.0' > $serverPath/v2ray/version.pl

	if [ "Darwin" == "$SYSOS" ];then
		echo 'macosx unavailable' > $install_tmp
		cat $curPath/tmp/v2ray.json > $serverPath/v2ray/config.json
		exit 0 
	fi

	bash <(curl -L -s https://install.direct/go.sh)
	cat $curPath/tmp/v2ray.json > /etc/v2ray/config.json

	echo 'install complete' > $install_tmp
}

Uninstall_v2ray()
{
	rm -rf $serverPath/v2ray
	echo "Uninstall completed" > $install_tmp
}

action=$1
if [ "${1}" == 'install' ];then
	Install_v2ray
else
	Uninstall_v2ray
fi
