
include $(TOPDIR)/rules.mk

APP_TITLE:=HomeProxy
APP_NAME:=homeproxy
APP_DEPENDS:=+sing-box +dnsmasq-full +firewall4 +kmod-nft-tproxy +ucode \
             +ucode-mod-uci +ca-certificates


APP_CONFFILES:=/etc/config/homeproxy \
               /etc/homeproxy/certs/ \
               /etc/homeproxy/resources/ \
               /etc/homeproxy/ruleset/

include ../../oui.mk
