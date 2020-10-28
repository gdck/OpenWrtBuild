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

# 这里的脚本在获取feeds后执行
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#=================================================
#本地启动脚本
#启动脚本插入到 'exit 0' 之前即可随系统启动运行。
sed -i '3i /etc/init.d/samba stop' package/base-files/files/etc/rc.local #停止samba服务
sed -i '4i /etc/init.d/samba disable' package/base-files/files/etc/rc.local #禁止samba服务开机自动
#=================================================
#git clone https://github.com/kenzok8/openwrt-packages package/op-packages
# 获取Lienol-package
#git clone https://github.com/Lienol/openwrt-package package/diy-packages/lienol
# 获取gdck-package
git clone https://github.com/gdck/openwrt-packages package/gdck
# 获取luci-app-adguardhome
pushd package/lean
rm -rf luci-app-adguardhome
git clone https://github.com/gdck/luci-app-adguardhome package/gdck/luci-app-adguardhome
#git clone https://github.com/rufengsuixing/luci-app-adguardhome package/lean/luci-app-adguardhome
# 获取luci-app-smartdns
git clone https://github.com/gdck/openwrt-packages/tree/packages/luci-app-smartdns package/lean/luci-app-smartdns
# 获取应用过滤luci-app-oaf
git clone https://github.com/destan19/OpenAppFilter package/lean/luci-app-oaf
# 获取luci-app-cupsd
git clone https://github.com/gdck/luci-app-cupsd package/lean/luci-app-cupsd
# 获取hello world和依赖
#git clone https://github.com/jerrykuku/lua-maxminddb package/diy-packages/helloworld/lua-maxminddb
#git clone https://github.com/jerrykuku/luci-app-vssr package/diy-packages/helloworld/luci-app-vssr
# 获取passwall
#git clone -b 3.6-40 https://github.com/liuran001/luci-app-passwall package/diy-packages/passwall
git clone -b https://github.com/gdck/luci-app-passwall-plus package/lean/passwall
# 获取可道云 luci-app-kodexplorer
#git clone https://github.com/silime/luci-app-kodexplorer package/lean/luci-app-kodexplorer
# 获取luci-app-diskman和依赖
mkdir -p package/diy-packages/luci-app-diskman && \
mkdir -p package/diy-packages/parted && \
wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Makefile -O package/lean/luci-app-diskman/Makefile
wget https://raw.githubusercontent.com/lisaac/luci-app-diskman/master/Parted.Makefile -O package/lean/parted/Makefile
# 获取luci-app-serverchan
git clone https://github.com/tty228/luci-app-serverchan package/lean/luci-app-serverchan
# 获取luci-app-control-weburl
git clone https://github.com/gdck/luci-app-control-weburl package/lean/luci-app-control-weburl
# 获取luci-app-wrtbwmon-zh
rm -rf luci-app-wrtbwmon
#git clone https://github.com/gdck/luci-app-wrtbwmon  package/lean/luci-app-wrtbwmon
#git clone https://github.com/kongfl888/luci-app-wrtbwmon package/lean/luci-app-wrtbwmon
git clone https://github.com/brvphoenix/luci-app-wrtbwmon-zh package/lean/luci-app-wrtbwmon
# 获取luci-app-koolproxy
git clone https://github.com/gdck/luci-app-koolproxy package/lean/luci-app-koolproxy
# 获取luci-app-qos-gargoyle
git clone https://github.com/gdck/luci-app-qos-gargoyle package/lean/luci-app-qos-gargoyle
# 获取luci-app-openclash 编译po2lmo
#git clone -b master https://github.com/vernesong/OpenClash package/diy-packages/openclash
#pushd package/diy-packages/openclash/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
#=================================================
# 清除默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#=================================================
# 清除旧版argon主题并拉取最新版
pushd package/lean
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd
#=================================================
#=================================================
# 修改BaiduPCS-web来源
#pushd package/lean
#rm -rf baidupcs-web
#git clone https://github.com/liuran001/baidupcs-web-lede baidupcs-web
#popd
