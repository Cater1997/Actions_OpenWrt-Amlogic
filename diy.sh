# 编辑默认的lan口ip地址
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 编辑默认的主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 编辑默认的luci显示的固件名称
#sed -i 's/ImmortalWrt/ImmortalWrt1/g' package/base-files/files/bin/config_generate

# Replace the default software source
# sed -i 's#openwrt.proxy.ustclug.org#mirrors.bfsu.edu.cn\\/openwrt#' package/lean/default-settings/files/zzz-default-settings

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

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# 拉取软件包
git clone https://github.com/CrazyPegasus/luci-app-accesscontrol-plus.git package/luci-app-accesscontrol-plus
git clone https://github.com/kongfl888/luci-app-adbyby-plus-lite.git package/luci-app-adbyby-plus-lite
git clone https://github.com/stevenjoezhang/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
git clone https://github.com/DustReliant/luci-app-filetransfer.git package/luci-app-filetransfer
git clone https://github.com/chenmozhijin/turboacc.git package/turboacc

# 其他调整
NAME=$"package/luci-app-unblockneteasemusic/root/usr/share/unblockneteasemusic" && mkdir -p $NAME/core
curl 'https://api.github.com/repos/UnblockNeteaseMusic/server/commits?sha=enhanced&path=precompiled' -o commits.json
echo "$(grep sha commits.json | sed -n "1,1p" | cut -c 13-52)">"$NAME/core_local_ver"
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/app.js -o $NAME/core/app.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/precompiled/bridge.js -o $NAME/core/bridge.js
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/ca.crt -o $NAME/core/ca.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.crt -o $NAME/core/server.crt
curl -L https://github.com/UnblockNeteaseMusic/server/raw/enhanced/server.key -o $NAME/core/server.key

sed -i 's#https://github.com/breakings/OpenWrt#https://github.com/ophub/kernel#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
#sed -i 's#ARMv8#openwrt_armvirt#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i 's#opt/kernel#kernel#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic

# 解除系统限制
ulimit -u unlimited
ulimit -n unlimited
ulimit -d unlimited
ulimit -m unlimited
ulimit -s unlimited
ulimit -t unlimited
ulimit -v unlimited
