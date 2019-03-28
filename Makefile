
TOP_DIR=$(PWD)
KCONFIG_DIR=$(TOP_DIR)/tools
CONFIG_DIR=$(TOP_DIR)/config

-include $(TOP_DIR)/.config
-include $(TOP_DIR)/build.mk

CONF=$(KCONFIG_DIR)/conf
MCONF=$(KCONFIG_DIR)/mconf

ifeq ($(CONFIG_IOT_MODEL_A),y)
MODEL_DIR=$(TOP_DIR)/mod-A
endif

ifeq ($(CONFIG_IOT_MODEL_B),y)
MODEL_DIR=$(TOP_DIR)/mod-B
endif

MOD_DIRS:=$(TOP_DIR)/mod-A $(TOP_DIR)/mod-B

all: prepare build test


prepare: kconfig
	@if [ ! -f .config ]; then \
		echo "Error >> There is NO .config, do make menuconfig"; \
		exit 1; \
	fi
	@if [ "$(CONFIG_HW_MODEL_IOT)" = "" ]; then \
		echo "Skip >> No IoT model selected at menuconfig!"; \
		exit 1; \
	fi
	@mkdir -p include/generated include/config


kconfig:
	$(MAKE) -C $(KCONFIG_DIR);


build:
	@CFLAGS+="$(EXTRA_CFLAGS)" \
	$(MAKE) -C $(MODEL_DIR)

test:
	@echo "========================="
	@echo Firmware Version: $(CONFIG_FIRMWARE_VERSION)
	@$(MODEL_DIR)/modinfo
	@echo "========================="


clean:
	@for d in $(MOD_DIRS); do \
		if [ -d $$d ];then \
			$(MAKE) -C $$d $@; \
		fi \
	done


distclean: clean
	@$(MAKE) -C $(KCONFIG_DIR) $<
	@rm -rf include
	@rm -rf .config .config.old


menuconfig: kconfig
	$(MCONF) $(CONFIG_DIR)/Config.in


oldconfig: kconfig
	$(CONF) --oldconfig $(CONFIG_DIR)/Config.in


genheaders: kconfig
	$(CONF) --silentoldconfig $(CONFIG_DIR)/Config.in


.PHONY: all clean

