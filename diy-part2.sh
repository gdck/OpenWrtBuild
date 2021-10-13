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
#=================================================================================================================
#
# 这里的脚本在获取feeds后执行
#=====================================================================================================
# Modify default IP 更改默认IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
#更改机器名
#sed -i 's/OpenWrt/LEDE/g' package/base-files/files/bin/config_generate
#添加软件源Lienol gdck
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
sed -i '$a src-git gdck https://github.com/gdck/openwrt-packages' feeds.conf.default
#================================================================================================================
#git clone https://github.com/kenzok8/openwrt-packages package/op-packages
# 获取Lienol-package
#git clone https://github.com/Lienol/openwrt-package package/diy-packages/lienol
# 获取gdck-package
# git clone https://github.com/gdck/openwrt-packages.git package/lean
#================================================================================================================
# MTK闭源驱动
sed -i '$a src-git mtk https://github.com/Nossiac/mtk-openwrt-feeds;lede-17.01' feeds.conf.default
#mtk https://github.com/Nossiac/mtk-openwrt-feeds #;lede-17.01
#然后执行：
scripts/feeds update -f mtk
scripts/feeds install -a -p mtk
#不要先以下模块
#rt2x00
#mt76
#cfg80211
#mac80211
#wpad
#supplicant
#=====================================================================================================
#更改版本号为编译时间
#sed -i 's/R20.10.20/R$(date +%Y.%m.%d.%H:%M)/g' package/lean/default-settings/files/zzz-default-settings
#sed -i "s/R2020.10.27.09:55/R$(date +%Y.%m.%d.%H:%M)/g" package/lean/default-settings/files/zzz-default-settings
#sed -i "s/R20.10.20/R$(date +%Y.%m.%d.%H:%M)/g" package/lean/default-settings/files/zzz-default-settings
#=====================================================================================================
sed -i '46i  185.199.111.133 raw.githubusercontent.com' package/base-files/files/etc/hosts
#=====================================================================================================
#本地启动脚本
#启动脚本插入到 'exit 0' 之前即可随系统启动运行。
sed -i '3i /etc/init.d/samba stop' package/base-files/files/etc/rc.local #停止samba服务
sed -i '4i /etc/init.d/samba disable' package/base-files/files/etc/rc.local #禁止samba服务开机自动
#=====================================================================================================
# 获取luci-app-diskman和依赖
# mkdir -p package/diy-packages/luci-app-diskman && \
# mkdir -p package/diy-packages/parted && \
# wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Makefile -O package/lean/luci-app-diskman/Makefile
# wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/lean/parted/Makefile
#================================================================================================================
# 获取应用过滤luci-app-oaf
git clone https://github.com/destan19/OpenAppFilter package/lean/luci-app-oaf
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
#==================================================================================================================
# 获取apple打印机luci-app-cupsd 
#git clone https://github.com/gdck/luci-app-cupsd.git package/lean/luci-app-cupsd
svn co  https://github.com/gdck/luci-app-cupsd/trunk package/lean/luci-app-cupsd
#==================================================================================================================
#获取智能DNSluci-app-smartdns
#rm -rf package/lean/luci-app-smartdns
svn co https://github.com/gdck/openwrt-packages/trunk/luci-app-smartdns package/lean/luci-app-smartdns
#rm -rf package/lean/smartdns
svn co https://github.com/gdck/openwrt-packages/trunk/smartdns package/lean/smartdns
#============================================================================================================
#获取luci-app-adguardhomeDNS
#pushd package/lean
#rm -rf package/lean/luci-app-adguardhome
git clone https://github.com/gdck/luci-app-adguardhome package/lean/luci-app-adguardhome
#git clone https://github.com/rufengsuixing/luci-app-adguardhome package/lean/luci-app-adguardhome
#======================================================================================================================
# 获取luci-app-wrtbwmon
#svn co https://github.com/gdck/openwrt-packages/branches/packages-19.07/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
#svn co https://github.com/gdck/openwrt-packages/branches/packages-19.07/wrtbwmon package/lean/wrtbwmon
#git clone https://github.com/kongfl888/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
#git clone https://github.com/brvphoenix/luci-app-wrtbwmon.git package/lean/luci-app-wrtbwmon
#============================================================================================================
# 获取luci-app-ser2net串口网络透传
#svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-ser2net package/lean/luci-app-ser2net
#==========================================================================================================
#  获取luci-app-socat一个多功能的网络工具
#svn co  https://github.com/gdck/openwrt-packages/trunk/luci-app-socat package/lean/luci-app-socat
#==========================================================================================================
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# 清除默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#===============================================================================================================================
#scripts/feeds update -a
#scripts/feeds install -a
#===============================================================================================================================
# 清除旧版argon主题并拉取最新版
pushd package/lean
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd

