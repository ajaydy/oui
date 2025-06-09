#
# Copyright (C) 2022 Jianhui Zhao <zhaojh329@gmail.com>
#
# This is free software, licensed under the MIT.
#

include $(TOPDIR)/rules.mk

APP_TITLE:=OUI built-in homeproxy
APP_NAME:=homeproxy

APP_DEPENDS  := +sing-box +firewall4 +kmod-nft-tproxy
APP_CONFFILES := /etc/config/homeproxy \
                 /etc/homeproxy/certs/ \
                 /etc/homeproxy/resources/ \
                 /etc/homeproxy/ruleset/
include ../../oui.mk

define Package/$(PKG_NAME)/install
	$(call Package/$(PKG_NAME)/install/default,$(1))
	$(CP) $(CURDIR)/files/etc $(1)/
endef

# call BuildPackage - OpenWrt buildroot signature
