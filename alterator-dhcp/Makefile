NAME=dhcp

all:
clean:
install: install-module install-data

include /usr/share/alterator/build/module.mak

install-data:
	install -d $(sysconfdir)/alterator/dhcp
	touch $(sysconfdir)/alterator/dhcp/general
	touch $(sysconfdir)/alterator/dhcp/static
	for i in bin/*; do \
	    install -Dpm755 $$i $(bindir)/$${i##*/}; \
	done
	install -Dpm 755 alterator-dhcp.hook $(libexecdir)/alterator/hooks/net-eth.d/alterator-dhcp
