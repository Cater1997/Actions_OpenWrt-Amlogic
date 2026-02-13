# 修改登录用户名（将 root 改为 admin）

# 1.修改系统账户文件
sed -i 's/^root:/admin:/' package/base-files/files/etc/passwd
sed -i 's/^root:/admin:/' package/base-files/files/etc/shadow

# 2.修改权限配置
sed -i 's/option username '"'"'root'"'"'/option username '"'"'admin'"'"'/' package/system/rpcd/files/rpcd.config

# 3.修改 LuCI 控制器（新版使用 ucode）
# 不同版本路径可能不同，以下命令覆盖常见位置
sed -i 's/duser: '"'"'root'"'"'/duser: '"'"'admin'"'"'/' feeds/luci/modules/luci-base/ucode/dispatcher.uc 2>/dev/null || true
sed -i 's/duser: '"'"'root'"'"'/duser: '"'"'admin'"'"'/' package/feeds/luci/luci-base/ucode/dispatcher.uc 2>/dev/null || true

# 4.修改旧版 Lua 控制器（兼容性保留）
sed -i 's/sysauth": "root"/sysauth": "admin"/' feeds/luci/modules/luci-base/luasrc/controller/admin/index.lua 2>/dev/null || true
sed -i 's/sysauth = "root"/sysauth = "admin"/' feeds/luci/modules/luci-base/luasrc/controller/admin/servicectl.lua 2>/dev/null || true

# 5.移除登录页面预填的 "root" 用户名
# 新版 LuCI 的 sysauth.htm 位置
if [ -f "feeds/luci/modules/luci-base/htdocs/luci-static/resources/view/sysauth.js" ]; then
  sed -i 's/placeholder: /placeholder: '"'"'admin'"'"', /' feeds/luci/modules/luci-base/htdocs/luci-static/resources/view/sysauth.js
else
# 旧版 HTML 方式
  find feeds/luci -name "sysauth.htm" -exec sed -i 's/value="<%=duser%>"/value="admin"/' {} \;
fi

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
