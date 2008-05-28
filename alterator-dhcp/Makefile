NAME=dhcp
DESCRIPTION="Alterator module for dhcp configuration"

INSTALL=/usr/bin/install

AWK_TRANSLATE = $(shell [ -d backend3 ] && for i in backend3/*; do file $$i | fgrep -qs 'awk script text' && echo $$i; done)

all: 
clean: 
install: install-backend install-po install-html install-ui

awk-update-po:
	$(XGETTEXT) --join-existing --add-comments -o$(POT_NAME) -L awk --keyword=N_ $(AWK_TRANSLATE)
	for i in $(PO_LANGUAGES);do \
	$(MSGMERGE) po/$$i.po $(POT_NAME) -o $$.new.po && mv $$.new.po po/$$i.po; \
	done

include /usr/share/alterator/build/po.mak
include /usr/share/alterator/build/ui2.mak
include /usr/share/alterator/build/backend.mak
include /usr/share/alterator/build/fbi.mak
include /usr/share/alterator/build/html-messages.mak

HTML_PO_TEMPLATE=ui/$(NAME)/html-messages.scm
