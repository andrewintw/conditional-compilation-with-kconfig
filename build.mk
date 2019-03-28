
-include .config

ifeq ($(CONFIG_WIFI),y)
EXTRA_CFLAGS += -DSUPPORT_WIFI
endif

ifeq ($(CONFIG_NAT),y)
EXTRA_CFLAGS += -DSUPPORT_NAT
endif

ifeq ($(CONFIG_IPV6),y)
EXTRA_CFLAGS += -DSUPPORT_IPV6
endif

ifeq ($(CONFIG_VPN),y)
EXTRA_CFLAGS += -DSUPPORT_VPN
endif

