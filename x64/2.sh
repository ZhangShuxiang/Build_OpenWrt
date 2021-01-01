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
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
sed -i 's/dnsmasq/dnsmasq-full/g' include/target.mk
#
cp -r /usr/bin/upx /workdir/openwrt/staging_dir/host/bin/
cp -r /usr/bin/upx-ucl /workdir/openwrt/staging_dir/host/bin/
cp /workdir/openwrt/build_dir/target-x86_64_musl/linux-x86_64/*/drivers/thermal/thermal_core.c thermal_sys.ko
#
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/wireless.radio${devidx}.disabled/a\			set wireless.radio${devidx}.cell_density=0' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i 's/encryption=none/encryption=psk-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
sed -i '/wireless.default_radio${devidx}.encryption/a\			set wireless.default_radio${devidx}.key=password' package/kernel/mac80211/files/lib/wifi/mac80211.sh
