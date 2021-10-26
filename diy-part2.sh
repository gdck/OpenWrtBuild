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
#===================================================================================

# Modify default IP 更改默认IP
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#===================================================================================

# 获取apple打印机luci-app-cupsd 
#git clone https://github.com/gdck/luci-app-cupsd.git package/lean/luci-app-cupsd
svn co  https://github.com/gdck/luci-app-cupsd/trunk package/lean/luci-app-cupsd

#===================================================================================

# 获取应用过滤luci-app-oaf
git clone https://github.com/destan19/OpenAppFilter package/lean/luci-app-oaf
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

#===================================================================================

#获取智能DNSluci-app-smartdns
#rm -rf package/lean/luci-app-smartdns
svn co https://github.com/gdck/openwrt-packages/trunk/luci-app-smartdns package/lean/luci-app-smartdns
#rm -rf package/lean/smartdns
svn co https://github.com/gdck/openwrt-packages/trunk/smartdns package/lean/smartdns
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
git clone https://github.com/brvphoenix/luci-app-wrtbwmon.git package/lean/luci-app-wrtbwmon

#============================================================================================================

