.SILENT:

##########
# Manala #
##########

include .manala/make/Makefile

###########
# Package #
###########

PACKAGE               = oauth2-proxy
PACKAGE_VERSION       = 2.2.0
PACKAGE_SOURCE        = https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-$(PACKAGE_VERSION).linux-amd64.go1.8.1.tar.gz
PACKAGE_DISTRIBUTIONS = wheezy jessie stretch

package.checkout:
	$(call log,Checkout)
	mkdir $(PACKAGE_BUILD_DIR)/$(PACKAGE)
	curl -L $(PACKAGE_SOURCE) \
		| bsdtar -xvf - -C $(PACKAGE_BUILD_DIR)/$(PACKAGE) --strip-components=1

package.prepare:
	$(call log,Prepare)
	mv $(PACKAGE_BUILD_DIR)/$(PACKAGE)/oauth2_proxy $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	chmod 755 $(PACKAGE_BUILD_DIR)/$(PACKAGE)/$(PACKAGE)
	cp -R $(PACKAGE_DIR)/debian/$(DISTRIBUTION) $(PACKAGE_BUILD_DIR)/$(PACKAGE)/debian

package.build:
	$(call log,Build)
	cd $(PACKAGE_BUILD_DIR)/$(PACKAGE) \
		&& debuild -us -uc -b
