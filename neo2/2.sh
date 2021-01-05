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
sed -i "s/timezone='UTC'/timezone='CST-8'/g" package/base-files/files/bin/config_generate
sed -i "/system.@system\\\[-1\\\].timezone/a\\		set system.@system\\\[-1\\\].zonename='Asia\\\/Shanghai'" package/base-files/files/bin/config_generate
sed -i "s/'0.openwrt.pool.ntp.org'/'ntp.ntsc.ac.cn'/g" package/base-files/files/bin/config_generate
sed -i "s/'1.openwrt.pool.ntp.org'/'cn.ntp.org.cn'/g" package/base-files/files/bin/config_generate
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk
#
cp -r /usr/bin/upx /workdir/openwrt/staging_dir/host/bin/
cp -r /usr/bin/upx-ucl /workdir/openwrt/staging_dir/host/bin/
#
sed -i 's/REJECT/ACCEPT/g' package/network/config/firewall/files/firewall.config
sed -i "s/ucidef_set_interface_lan \"eth0\"/ucidef_set_interface_lan_wan \"eth0.1\" \"eth0\"/g" target/linux/sunxi/base-files/etc/board.d/02_network
sed -i "s/ucidef_set_interface_lan 'eth0'/ucidef_set_interface_wan 'eth0'/g" package/base-files/files/etc/board.d/99-default_network
sed -i "s/ucidef_set_interface_wan 'eth1'/ucidef_set_interface_lan 'eth1'/g" package/base-files/files/etc/board.d/99-default_network
#
sed -i 's/htmode=HT20/htmode=HT40/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/wireless.radio${devidx}.disabled/a\			set wireless.radio${devidx}.cell_density=0' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/wireless.radio${devidx}.disabled/a\			set wireless.radio${devidx}.noscan=1' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/encryption=none/encryption=psk-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/wireless.default_radio${devidx}.encryption/a\			set wireless.default_radio${devidx}.key=password' package/kernel/mac80211/files/lib/wifi/mac80211.sh
