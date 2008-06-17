%define _altdata_dir %_datadir/alterator

Name: alterator-dhcp
Version: 0.1
Release: alt9
Packager: Grigory Batalov <bga@altlinux.ru>

Summary: alterator module for dhcp conf file editing
License: GPL
Group: System/Configuration/Other
Url: http://wiki.sisyphus.ru/Alterator

Source: %name-%version.tar

BuildArch: noarch

Requires: alterator >= 2.9 gettext dhcp-server
Requires: alterator-services
Conflicts: alterator-fbi < 0.15-alt2

BuildPreReq: alterator >= 3.1, alterator-fbi >= 0.7-alt1

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
%find_lang %name

%files -f %name.lang
%_altdata_dir/applications/*
%_altdata_dir/ui/*/
%_altdata_dir/help/*/*
%_var/www/html/*
%_alterator_backend3dir/*

%changelog
* Tue Jun 17 2008 Grigory Batalov <bga@altlinux.ru> 0.1-alt9
- Require alterator-services instead of alterator-chkconfig.

* Fri Jun 06 2008 Grigory Batalov <bga@altlinux.ru> 0.1-alt8
- Replace label tag with a translation on the help page.

* Wed May 28 2008 Grigory Batalov <bga@altlinux.ru> 0.1-alt6.M41.1
- Service restart link update.
- Hide service restart link on subnet configuration page.
- Russian translation update.

* Wed May 28 2008 Grigory Batalov <bga@altlinux.ru> 0.1-alt5.M41.1
- Change help paths to the new style (slazav@).
- Backport to branch 4.1.

* Thu May 15 2008 Grigory Batalov <bga@altlinux.ru> 0.1-alt4.M40.1
- Backport to branch 4.0.

* Fri Feb 15 2008 Grigory Batalov <bga@altlinux.ru> 0.1-alt4
- Set more restrictions on subnet parameters.

* Thu Dec 13 2007 Grigory Batalov <bga@altlinux.ru> 0.1-alt3
- Use dash in "DHCP server", "IP address" and "MAC address" translation.
- Russian help page.
- Add missing "ddns-update-style" to the config.
- Fix empty subnet deletion.

* Mon Jul 09 2007 Grigory Batalov <bga@altlinux.ru> 0.1-alt2
- Switch to new menu system.

* Thu Jun 07 2007 Grigory Batalov <bga@altlinux.ru> 0.1-alt1
- Specfile cleanup.
- Backend rewritten in Awk.

* Sun Apr 1 2007 Bogomolov Alex <lekseich@altlinux> 0.0-alt0
- Initial release
