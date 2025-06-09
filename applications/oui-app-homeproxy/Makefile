#
# Copyright (C) 2022 Jianhui Zhao <zhaojh329@gmail.com>
#
# This is free software, licensed under the MIT.
#

include $(TOPDIR)/rules.mk

APP_TITLE:=OUI built-in homeproxy
APP_NAME:=homeproxy

APP_DEPENDS:= +sing-box +firewall4 +kmod-nft-tproxy
define Package/$(PKG_NAME)/conffiles
/etc/config/homeproxy
/etc/homeproxy/certs/
/etc/homeproxy/resources/
/etc/homeproxy/ruleset/
endef
include ../../oui.mk

# call BuildPackage - OpenWrt buildroot signature
