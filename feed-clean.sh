#!/bin/bash

# Description: OpenWrt DIY script run after Update feeds
function merge_package() {
    # 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    if [[ $# -lt 3 ]]; then
        echo "Syntax error: [$#] [$*]" >&2
        return 1
    fi
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    # 使用循环逐个移动文件夹
    for folder in "$@"; do
        mv -f "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}

#Delete duplicate file
rm -rf feeds/luci/applications/luci-app-aliddns
rm -rf feeds/luci/applications/luci-app-autoreboot
rm -rf feeds/luci/applications/luci-app-baidupcs-web
rm -rf feeds/luci/applications/luci-app-beardropper
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-fileassistant
rm -rf feeds/luci/applications/luci-app-filebrowser
rm -rf feeds/luci/applications/luci-app-gost
rm -rf feeds/luci/applications/luci-app-guest-wifi
rm -rf feeds/luci/applications/luci-app-iptvhelper
rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/luci/applications/luci-app-onliner
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-openvpn-server
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-pppoe-relay
rm -rf feeds/luci/applications/luci-app-pppoe-server
rm -rf feeds/luci/applications/luci-app-ramfree
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-sms-tool
rm -rf feeds/luci/applications/luci-app-socat
rm -rf feeds/luci/applications/luci-app-softethervpn
rm -rf feeds/luci/applications/luci-app-ssr-mudb-server
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/luci/applications/luci-app-syncthing
rm -rf feeds/luci/applications/luci-app-sysuh3c
rm -rf feeds/luci/applications/luci-app-timecontrol
rm -rf feeds/luci/applications/luci-app-udp2raw
rm -rf feeds/luci/applications/luci-app-unblockneteasemusic
rm -rf feeds/luci/applications/luci-app-usb3disable
rm -rf feeds/luci/applications/luci-app-verysync
rm -rf feeds/luci/applications/luci-app-vssr
rm -rf feeds/luci/applications/luci-app-watchcat
rm -rf feeds/luci/applications/luci-app-wrtbwmon
rm -rf feeds/luci/applications/luci-app-xlnetacc
rm -rf feeds/luci/applications/luci-app-xunlei
rm -rf feeds/luci/applications/luci-theme-argon
#rm -rf feeds/packages/net/naiveproxy
#rm -rf feeds/packages/net/xray-core
#rm -rf feeds/packages/net/xray-plugin
rm -rf feeds/packages/net/brook
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/dns2socks
rm -rf feeds/packages/net/dns2tcp
rm -rf feeds/packages/net/hysteria
rm -rf feeds/packages/net/smartdns
rm -rf feeds/packages/net/shadowsocks-rust
rm -rf feeds/packages/net/mosdns
# rm -rf feeds/luci/applications/luci-app-adbyby-plus
# merge_package openwrt-23.05 https://github.com/immortalwrt/luci feeds/luci/applications applications/luci-app-adbyby-plus
#rm -rf feeds/packages/net/frp
#merge_package openwrt-23.05 https://github.com/immortalwrt/packages feeds/packages/net net/frp
# svn co https://github.com/immortalwrt/packages/branches/openwrt-23.05/net/frp feeds/packages/net/frp
#rm -rf feeds/packages/lang/golang
# git clone https://github.com/openwrt/packages/tree/openwrt-23.05/lang/golang feeds/packages/lang/golang
#merge_package openwrt-23.05 https://github.com/immortalwrt/packages feeds/packages/lang lang/golang
./scripts/feeds update -a
