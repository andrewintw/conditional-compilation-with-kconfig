# conditional-compilation-with-kconfig
How to use menuconfig to management your build system.


## How to use


1.Do make menuconfig


	$ make menuconfig


2.You can change version string, select using Mode A or Model B, and also choose supported features.


	(1.2.3) Firmware Version

	[*] IoT devices
	      Model Name (Model A)  --->
	[*] Support WiFi (NEW)
	[ ] Support NAT (NEW)
	[*] Support IPv6 (only for Model A)


3.After saving config, please check .config on the top directory. Ex:


	$ cat .config
	#
	# Automatically generated file; DO NOT EDIT.
	# Linux Kernel Configuration
	#
	CONFIG_FIRMWARE_VERSION="1.2.3"
	CONFIG_HW_MODEL_IOT=y
	CONFIG_IOT_MODEL_A=y
	# CONFIG_IOT_MODEL_B is not set
	CONFIG_WIFI=y
	# CONFIG_NAT is not set
	CONFIG_IPV6=y


4.run make to build the model sources and then get the executed result.


	$ make
	make -C /home/andrew/tftpboot/conditional-compilation-with-kconfig/tools;
	make[1]: Entering directory `/home/andrew/tftpboot/conditional-compilation-with-kconfig/tools'
	make[1]: Nothing to be done for `all'.
	make[1]: Leaving directory `/home/andrew/tftpboot/conditional-compilation-with-kconfig/tools'
	make[1]: Entering directory `/home/andrew/tftpboot/conditional-compilation-with-kconfig/mod-A'
	cc -DSUPPORT_WIFI -DSUPPORT_IPV6 -o modinfo modinfo.c 
	make[1]: Leaving directory `/home/andrew/tftpboot/conditional-compilation-with-kconfig/mod-A'
	=========================
	Firmware Version: 1.2.3
	Model A support features:
	* WiFi
	* IPv6
	=========================


6.Try to find the CFLAGS in C code. And also check the following files:


	.
	|-- Makefile
	|-- build.mk					# for creating extra CFLAGS according to your menuconfig result.
	`-- config
	    |-- Config-customize.in		# for customize options
	    `-- Config.in				# for shows the main menu



7.clean

	$ make clean		# clean C code only
	$ make distclean	# clean everything including .config file


~ END ~