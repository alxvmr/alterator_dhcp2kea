NAME=dhcp

all:
clean:
install: install-module install-data

include /usr/share/alterator/build/module.mak

install-data:
	install -d $(sysconfdir)/alterator/dhcp
	touch $(sysconfdir)/alterator/dhcp/general
	touch $(sysconfdir)/alterator/dhcp/static
	install -d $(sysconfdir)/alterator/dhcp6
	touch $(sysconfdir)/alterator/dhcp6/general
	touch $(sysconfdir)/alterator/dhcp6/static
	install -Dpm755 bin/alterator-dhcp-reset $(bindir)/alterator-dhcp-reset
	install -Dpm644 bin/alterator-dhcp-functions $(bindir)/alterator-dhcp-functions
	install -Dpm 755 alterator-dhcp.hook $(libexecdir)/alterator/hooks/net-eth.d/alterator-dhcp
	install -dpm 755 $(libexecdir)/alterator/hooks/dhcp.d/
