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
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-ssr-plus
#-rf feeds/luci/applications/luci-theme-argon
#rm -rf feeds/packages/net/naiveproxy
#rm -rf feeds/packages/net/xray-core
rm -rf feeds/passwallpackages/sing-box
rm -rf feeds/passwallpackages/xray-core
rm -rf feeds/passwallpackages/xray-plugin
#rm -rf feeds/packages/net/xray-plugin
#rm -rf feeds/packages/net/brook
#rm -rf feeds/packages/net/chinadns-ng
#rm -rf feeds/packages/net/dns2socks
#rm -rf feeds/packages/net/dns2tcp
#rm -rf feeds/packages/net/hysteria
#rm -rf feeds/packages/net/smartdns
#rm -rf feeds/packages/net/shadowsocks-rust
#rm -rf feeds/packages/net/mosdns
#rm -rf feeds/packages/net/frp
merge_package main https://github.com/kenzok8/small-package feeds/luci/applications luci-app-bypass
#rm -rf feeds/packages/lang/golang
# git clone https://github.com/openwrt/packages/tree/openwrt-23.05/lang/golang feeds/packages/lang/golang
#merge_package openwrt-23.05 https://github.com/immortalwrt/packages feeds/packages/lang lang/golang
./scripts/feeds update -a
