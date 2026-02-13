#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 取消与瑞莎 E52c 无关的软件包
sed -i 's/CONFIG_PACKAGE_arm-trusted-firmware-microchipsw=y/# CONFIG_PACKAGE_arm-trusted-firmware-microchipsw is not set/' .config
sed -i 's/CONFIG_PACKAGE_audit=y/# CONFIG_PACKAGE_audit is not set/' .config
sed -i 's/CONFIG_PACKAGE_auditd=y/# CONFIG_PACKAGE_auditd is not set/' .config
sed -i 's/CONFIG_PACKAGE_autosamba=y/# CONFIG_PACKAGE_autosamba is not set/' .config
sed -i 's/CONFIG_BUSYBOX_CONFIG_PAM=y/# CONFIG_BUSYBOX_CONFIG_PAM is not set/' .config
sed -i 's/CONFIG_BUSYBOX_CONFIG_RPC=y/# CONFIG_BUSYBOX_CONFIG_RPC is not set/' .config
sed -i 's/CONFIG_PACKAGE_kexec-tools=y/# CONFIG_PACKAGE_kexec-tools is not set/' .config
sed -i 's/CONFIG_PACKAGE_lldpd=y/# CONFIG_PACKAGE_lldpd is not set/' .config
sed -i 's/CONFIG_PACKAGE_onionshare-cli=y/# CONFIG_PACKAGE_onionshare-cli is not set/' .config
sed -i 's/CONFIG_PACKAGE_pcat-manager=y/# CONFIG_PACKAGE_pcat-manager is not set/' .config
sed -i 's/CONFIG_PACKAGE_policycoreutils=y/# CONFIG_PACKAGE_policycoreutils is not set/' .config

## 常用OpenWrt软件包源码合集，同步上游更新！
## 通用版luci适合18.06与19.07
# echo 'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default


## 解除系统限制
ulimit -u 10000
ulimit -n 4096
ulimit -d unlimited
ulimit -m unlimited
ulimit -s unlimited
ulimit -t unlimited
ulimit -v unlimited

