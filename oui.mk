#
# Copyright (C) 2022 Jianhui Zhao <zhaojh329@gmail.com>
#
# This is free software, licensed under the MIT.
#

include ${CURDIR}/../../version.mk
include ${CURDIR}/../../node.mk

PKG_NAME:=$(notdir ${CURDIR})
PKG_VERSION:=$(strip $(call findrev))
PKG_RELEASE?=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=oui
  CATEGORY:=Oui
  SUBMENU:=Applications
  TITLE:=$(APP_TITLE)
  DEPENDS:=+oui-ui-core $(APP_DEPENDS)
  PKGARCH:=all
endef

define Build/Prepare
	if [ -d ./htdoc ]; then \
		$(CP) ./htdoc $(PKG_BUILD_DIR); \
		echo "VITE_APP_NAME=$(APP_NAME)" > $(PKG_BUILD_DIR)/htdoc/.env.local; \
	fi
endef

define Build/Compile
	if [ -d $(PKG_BUILD_DIR)/htdoc ]; then \
		$(NPM) --prefix $(PKG_BUILD_DIR)/htdoc install && \
		$(NPM) --prefix $(PKG_BUILD_DIR)/htdoc run build && \
		$(RM) -rf $(PKG_BUILD_DIR)/htdoc/node_modules; \
	fi
endef

define Package/$(PKG_NAME)/install
	@echo ">>> Starting install for $(PKG_NAME)"

	if [ -d ./files/etc ]; then \
		echo ">>> Found ./files/etc, installing to $(1)/etc"; \
		$(INSTALL_DIR) $(1)/etc; \
		$(CP) -rv ./files/etc/* $(1)/etc/; \
	else \
		echo ">>> ./files/etc not found, skipping etc install"; \
	fi

	if [ -d $(PKG_BUILD_DIR)/htdoc/dist ]; then \
		echo ">>> Copying dist to $(1)/www/views"; \
		$(INSTALL_DIR) $(1)/www/views; \
		$(CP) -rv $(PKG_BUILD_DIR)/htdoc/dist/* $(1)/www/views/; \
	else \
		echo ">>> $(PKG_BUILD_DIR)/htdoc/dist not found, skipping view install"; \
	fi

	if [ -f ./files/menu.json ]; then \
		echo ">>> Installing menu.json to $(1)/usr/share/oui/menu.d"; \
		$(INSTALL_DIR) $(1)/usr/share/oui/menu.d; \
		$(INSTALL_CONF) ./files/menu.json $(1)/usr/share/oui/menu.d/$(APP_NAME).json; \
	else \
		echo ">>> ./files/menu.json not found, skipping menu"; \
	fi

	if [ -d ./files/rpc ]; then \
		echo ">>> Copying rpc to $(1)/usr/share/oui/rpc"; \
		$(INSTALL_DIR) $(1)/usr/share/oui/rpc; \
		$(CP) -rv ./files/rpc/* $(1)/usr/share/oui/rpc/; \
	else \
		echo ">>> ./files/rpc not found, skipping rpc"; \
	fi
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
