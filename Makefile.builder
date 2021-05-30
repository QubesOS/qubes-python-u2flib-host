DEBIAN_BUILD_DIRS.vm-stretch := debian-pkg/debian
DEBIAN_BUILD_DIRS.vm-buster := debian-pkg/debian
DEBIAN_BUILD_DIRS.vm-bullseye := debian-pkg/debian
DEBIAN_BUILD_DIRS := $(DEBIAN_BUILD_DIRS.$(PACKAGE_SET)-$(DIST))
ifeq ($(filter $(DIST), centos7 centos8 centos-stream8),)
RPM_SPEC_FILES := python3-u2flib-host.spec
endif

NO_ARCHIVE := 1

ifneq ($(filter $(DISTRIBUTION), debian qubuntu),)
SOURCE_COPY_IN := source-debian-copy-in
endif

source-debian-copy-in: VERSION = $(shell cat $(ORIG_SRC)/version)
source-debian-copy-in: ORIG_FILE = $(CHROOT_DIR)/$(DIST_SRC)/python-u2flib-host_$(VERSION).orig.tar.gz
source-debian-copy-in: SRC_FILE  = $(ORIG_SRC)/python-u2flib-host-$(VERSION).tar.gz
source-debian-copy-in:
	cp -p $(SRC_FILE) $(ORIG_FILE)
	tar xzf $(SRC_FILE) -C $(CHROOT_DIR)/$(DIST_SRC)/debian-pkg --strip-components=1
	cp $(ORIG_SRC)/00*.patch $(CHROOT_DIR)/$(DIST_SRC)/debian-pkg/debian/patches/
	rm -f $(CHROOT_DIR)/$(DIST_SRC)/debian-pkg/debian/patches/series
	cat $(ORIG_SRC)/debian-pkg/debian/patches/series $(ORIG_SRC)/debian-series.conf >> $(CHROOT_DIR)/$(DIST_SRC)/debian-pkg/debian/patches/series



# vim: ft=make
