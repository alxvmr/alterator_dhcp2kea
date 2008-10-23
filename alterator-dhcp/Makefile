NAME=dhcp

all: 
clean: 
install: install-module install-data

include /usr/share/alterator/build/module.mak

install-data:
	install -d $(sysconfdir)/alterator/dhcp
	touch $(sysconfdir)/alterator/dhcp/general
	touch $(sysconfdir)/alterator/dhcp/static
