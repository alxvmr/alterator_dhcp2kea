Name: alterator-dhcp
Version: 0.1
Release: alt2
Packager: Grigory Batalov <bga@altlinux.ru>

Summary: alterator module for dhcp conf file editing
License: GPL
Group: System/Configuration/Other
Url: http://wiki.sisyphus.ru/Alterator

Source: %name-%version.tar

BuildArch: noarch

Requires: alterator >= 2.9 gettext dhcp-server
Requires: alterator-chkconfig

BuildPreReq: alterator >= 2.9-alt0.10, alterator-fbi >= 0.7-alt1

# Automatically added by buildreq on Mon Jul 11 2005 (-bi)
BuildRequires: alterator

%description
DHCP configuration alterator module

%prep
%setup -q

%build
%make_build libdir=%_libdir

%install
%makeinstall HTMLROOT=%buildroot%_var/www/
install -D -m644 applications/dhcp.desktop %buildroot/%_datadir/alterator/applications/dhcp.desktop
%find_lang %name

%files -f %name.lang
%_var/www/html/*
%_alterator_backend3dir/*
%_datadir/alterator/applications/*

%changelog
* Mon Jul 09 2007 Grigory Batalov <bga@altlinux.ru> 0.1-alt2
- Switch to new menu system.

* Thu Jun 07 2007 Grigory Batalov <bga@altlinux.ru> 0.1-alt1
- Specfile cleanup.
- Backend rewritten in Awk.

* Sun Apr 1 2007 Bogomolov Alex <lekseich@altlinux> 0.0-alt0
- Initial release
