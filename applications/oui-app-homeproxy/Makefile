include $(TOPDIR)/rules.mk

PKG_NAME:=oui-app-homeproxy
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/oui.mk

define Package/$(PKG_NAME)
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=OUI front‑end for HomeProxy
  DEPENDS:=+homeproxy +sing-box +ouicore
endef

define Package/$(PKG_NAME)/description
A clean Vue 3 interface (OUI) to configure HomeProxy on OpenWrt systems that
don’t ship LuCI.
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
