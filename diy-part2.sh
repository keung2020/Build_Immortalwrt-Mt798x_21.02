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

# 修改openwrt登陆地址,把下面的192.168.1.1修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.168.1/g' package/base-files/files/bin/config_generate

# Fix supplicant name error
sed -i 's/DEPENDS:=+wpa_supplicant/DEPENDS:=+wpa-supplicant/g' feeds/packages/net/ieee8021xclient/Makefile

# Modify default theme
sed -i "3a\uci set luci.main.mediaurlbase=/luci-static/material" package/emortal/default-settings/files/99-default-settings
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify Laug
sed -i 's/auto/zh_cn/g' package/emortal/default-settings/files/99-default-settings

# Modify Adyby Update Script
sed -i 's/https:\/\/adbyby\.coding\.net\/p\/xwhyc-rules\/d\/xwhyc-rules\/git\/raw\/master\//https:\/\/cdn.jsdelivr.net\/gh\/kongfl888\/ad-rules\//g' feeds/luci/applications/luci-app-adbyby-plus/root/usr/share/adbyby/adupdate.sh
sed -i 's/https:\/\/adbyby\.coding\.net\/p\/xwhyc-rules\/d\/xwhyc-rules\/git\/raw\/master\//https:\/\/cdn.jsdelivr.net\/gh\/kongfl888\/ad-rules\//g' feeds/luci/applications/luci-app-adbyby-plus/root/usr/share/adbyby/adbybyupdate.sh
sed -i 's/https:\/\/adbyby\.coding\.net\/p\/xwhyc-rules\/d\/xwhyc-rules\/git\/raw\/master\//https:\/\/cdn.jsdelivr.net\/gh\/kongfl888\/ad-rules\//g' feeds/luci/applications/luci-app-adbyby-plus/root/usr/share/adbyby/admem.sh

# 修改主机名字，把ImmortalWrt修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/ImmortalWrt/BrianRT_$(TZ=UTC-8 date "+%Y%m%d")/g' package/base-files/files/bin/config_generate

# 增加个性名字
# sed -i "24a\sed -i \'/DISTRIB_RELEASE/d\' /etc/openwrt_release" package/emortal/default-settings/files/zzz-default-settings
# sed -i "25a\echo \"DISTRIB_RELEASE=\'SNAPSHOT\'\" >> /etc/openwrt_release" package/emortal/default-settings/files/zzz-default-settings
# sed -i "24a\sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release" package/emortal/default-settings/files/zzz-default-settings
# sed -i "25a\echo \"DISTRIB_REVISION=\'18.06 by Openwrt\'\" >> /etc/openwrt_release" package/emortal/default-settings/files/zzz-default-settings
sed -i "24a\sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release" package/emortal/default-settings/files/99-default-settings
sed -i "25a\echo \"DISTRIB_DESCRIPTION=\'BrianLuo Compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ ImmortalWrt 21.02 \'\" >> /etc/openwrt_release" package/emortal/default-settings/files/99-default-settings

# 设置密码为空
sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/emortal/default-settings/files/99-default-settings                                                            
