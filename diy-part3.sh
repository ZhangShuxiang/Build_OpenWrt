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

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.20/g' package/base-files/files/bin/config_generate

sed -i 's/REJECT/ACCEPT/g' package/network/config/firewall/files/firewall.config

sed -i 's/ucidef_set_interface_lan 'eth0'/ucidef_set_interface_wan 'eth0'/g' package/base-files/files/etc/board.d/99-default_network
sed -i 's/ucidef_set_interface_wan 'eth1'/ucidef_set_interface_lan 'eth1'/g' package/base-files/files/etc/board.d/99-default_network

sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
