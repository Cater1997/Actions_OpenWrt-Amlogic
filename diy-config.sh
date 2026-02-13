# 编辑默认 LAN 口 IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 编辑默认固件名称
#sed -i 's/ImmortalWrt/ImmortalWrt1/g' package/base-files/files/bin/config_generate

# 编辑默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

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

# 修改 luci-app-amlogic 配置
sed -i 's#https://github.com/breakings/OpenWrt#https://github.com/ophub/kernel#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i 's#opt/kernel#kernel#g' package/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
