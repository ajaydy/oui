include $(TOPDIR)/rules.mk          # always first

APP_TITLE     := OUI built-in HomeProxy
APP_NAME      := homeproxy
APP_DEPENDS   := +sing-box +firewall4 +kmod-nft-tproxy

# just list what should survive upgrades / sysupgrade
APP_CONFFILES := /etc/config/homeproxy \
                 /etc/homeproxy/certs/ \
                 /etc/homeproxy/resources/ \
                 /etc/homeproxy/ruleset/

include ../../oui.mk                # always last
