#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
#修改内核5.10
#sed -i ' s/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g ' target/linux/ramips/Makefile
#sed -i ' s/KERNEL_TESTING_PATCHVER:=5.10/KERNEL_TESTING_PATCHVER:=5.15/g ' target/linux/ramips/Makefile

sed -i ' s/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g ' target/linux/ramips/Makefile
sed -i ' s/KERNEL_TESTING_PATCHVER:=5.10/KERNEL_TESTING_PATCHVER:=5.15/g ' target/linux/ramips/Makefile

#===================================================================================
# Modify default IP 更改默认IP
# 修改openwrt登陆地址,把下面的192.168.2.1修改成你想要的就可以了
# 把config_generate文件中的192.168.1.1替换为192.168.1.253
#sed -i 's/192.168.1.1/192.168.1.253/g' package/base-files/files/bin/config_generate

#===================================================================================
# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
#sed -i 's/OpenWrt/OpenWrt-123/g' ./package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/OpenWrt/g' ./package/base-files/files/bin/config_generate
#===================================================================================
# 本地启动脚本
# 启动脚本插入到 'exit 0' 之前即可随系统启动运行。
#sed -i '3i,/etc/init.d/samba stop' ./package/base-files/files/etc/rc.local #停止samba服务
#sed -i '4i,/etc/init.d/samba disable' ./package/base-files/files/etc/rc.local #禁止samba服务开机自动

#===================================================================================
# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' ./package/lean/default-settings/files/zzz-default-settings

#===================================================================================
# 修改703N的固件16M把tiny-tp-link.mk中227行的4替换成16
sed '227s/4/16/' ./target/linux/ath79/image/tiny-tp-link.mk

# 修改703N的固件16M大小
sed 's/0x3d0000/0xfd0000/g' target/linux/ath79/dts/ar9331_tplink_tl-wr703n_tl-mr10u.dtsi
sed 's/0x3f0000/0xff0000/g' target/linux/ath79/dts/ar9331_tplink_tl-wr703n_tl-mr10u.dtsi

 
# 703N的USB 修改tiny-tp-link.mk中230行的kmod-usb-chipidea2替换成kmod-usb-core kmod-usb2
# sed -i 's/kmod-usb-chipidea2/kmod-usb-core kmod-usb2/g' ./target/linux/ath79/image/tiny-tp-link.mk

#===================================================================================
# 获取apple-cupsd打印机服务luci-app-cupsd 
git clone https://github.com/gdck/luci-app-cupsd.git package/lean/luci-app-cupsd
#svn co  https://github.com/gdck/luci-app-cupsd/trunk package/lean/luci-app-cupsd

#==============================================================================================
# 获取 luci-app-virtualhere_luci-app-vhUSBService 网络共享USB设备
#git clone https://github.com/gdck/luci-app-vhUSBService.git package/lean/luci-app-vhUSBService
git clone https://github.com/love23o/luci-app-vhUSBService.git package/lean/luci-app-vhUSBService
#svn co  https://github.com/gdck/luci-app-vhUSBService/trunk package/lean/luci-app-vhUSBService

#==============================================================================================
#Openwrt 标准的软件中心linkease/istore
git clone https://github.com/linkease/istore.git package/lean/istore
echo >> feeds.conf.default
echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
./scripts/feeds update istore
./scripts/feeds install -d y -p istore luci-app-store

#===================================================================================
# 获取应用过滤luci-app-oaf
git clone https://github.com/destan19/OpenAppFilter package/lean/luci-app-oaf
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

#===================================================================================
# 获取智能DNSluci-app-smartdns
rm -rf package/lean/luci-app-smartdns
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/lean/luci-app-smartdns
#svn co https://github.com/gdck/openwrt-packages/trunk/luci-app-smartdns package/lean/luci-app-smartdns
#svn co https://github.com/pymumu/luci-app-smartdns package/lean/luci-app-smartdns
rm -rf package/lean/smartdns
#svn co https://github.com/gdck/openwrt-packages/trunk/smartdns package/lean/smartdns
svn co https://github.com/pymumu/smartdns package/lean/smartdns

#------------------------------------------------------------------------------------
#获取luci-app-adguardhomeDNS
#pushd package/lean
#rm -rf package/lean/luci-app-adguardhome
git clone https://github.com/gdck/luci-app-adguardhome package/lean/luci-app-adguardhome
#git clone https://github.com/rufengsuixing/luci-app-adguardhome package/lean/luci-app-adguardhome

#============================================================================================================
# 获取luci-app-wrtbwmon
#svn co https://github.com/gdck/openwrt-packages/branches/packages-19.07/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
#svn co https://github.com/gdck/openwrt-packages/branches/packages-19.07/wrtbwmon package/lean/wrtbwmon
#git clone https://github.com/kongfl888/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
#rm -rf package/lean/luci-app-wrtbwmon
#svn co https://github.com/brvphoenix/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon

#============================================================================================================
# 获取luci-app-ser2net串口网络透传
svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-ser2net package/lean/luci-app-ser2net

#==========================================================================================================
# 获取luci-app-socat一个多功能的网络工具
#git clone https://github.com/nickilchen/luci-app-socat package/lean/luci-app-socat
svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-socat package/lean/luci-app-socat

#==========================================================================================================
# 获取通过arp实现的在线人员查看的luci界面，统计误差为arp老化时间
git clone https://github.com/gdck/luci-app-onliner package/lean/luci-app-onliner

#==========================================================================================================
#Xinetd：即extended internet daemon，是新一代的网络守护进程服务程序，又叫超级Internet服务器，
#常用来管理多种轻量级Internet服务。Xinetd提供类似于inetd+tcp_wrapper的功能，但是更加强大和安全。
#svn co https://github.com/openwrt/luci/trunk/applications/luci-app-xinetd package/lean/luci-app-xinetd
svn co https://github.com/gdck/openwrt-packages/trunk/luci-app-xinetd package/lean/luci-app-xinetd

#===========================================================================================
./scripts/feeds update  -a
./scripts/feeds install -a

