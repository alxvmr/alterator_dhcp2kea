NAME=kea

all:
clean:
install: install-module install-data

include /usr/share/alterator/build/module.mak

install-data:
	install -d $(sysconfdir)/alterator/kea
	touch $(sysconfdir)/alterator/kea/general
	touch $(sysconfdir)/alterator/kea/static
	install -d $(sysconfdir)/alterator/kea6
	touch $(sysconfdir)/alterator/kea6/general
	touch $(sysconfdir)/alterator/kea6/static
	install -Dpm755 bin/alterator-kea-reset $(bindir)/alterator-kea-reset
	install -Dpm644 bin/alterator-kea-functions $(bindir)/alterator-kea-functions
	install -Dpm 755 alterator-kea.hook $(libexecdir)/alterator/hooks/net-eth.d/alterator-kea
	install -dpm 755 $(libexecdir)/alterator/hooks/kea.d/
