#!/bin/bash
#===============================================
# Description: DIY script
# File name: diy-script.sh
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#===============================================

# 修改版本为编译日期，数字类型。
date_version=$(date +"%Y%m%d%H")
echo $date_version > version

# 为iStoreOS固件版本加上编译作者
author="nanosunny"
sed -i "s/DISTRIB_DESCRIPTION.*/DISTRIB_DESCRIPTION='%D %V ${date_version} by ${author}'/g" package/base-files/files/etc/openwrt_release
sed -i "s/OPENWRT_RELEASE.*/OPENWRT_RELEASE=\"%D %V ${date_version} by ${author}\"/g" package/base-files/files/usr/lib/os-release

# 拉取我的软件包仓库
# echo 'src-git xmpackages https://github.com/nanosunny/openwrt-packages2.git;main' >> feeds.conf.default

# 修复 ubus lua子目录 cmake_minimum_required 版本过低
UBUS_LUA_CMAKE="./package/system/ubus/src/lua/CMakeLists.txt"
if [ -f "${UBUS_LUA_CMAKE}" ];then
  echo "修复ubus lua CMakeLists.txt cmake_minimum_required"
  sed -i '1s/^cmake_minimum_required(VERSION 2.8)/cmake_minimum_required(VERSION 3.5)/' "${UBUS_LUA_CMAKE}"
fi
