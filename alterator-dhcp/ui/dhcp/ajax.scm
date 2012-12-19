(define-module (ui dhcp ajax)
    :use-module (alterator ajax)
    :use-module (alterator woo)
    :export (init))

(define *parameters* '("daemon" "iface" "ip_start" "ip_end" "client_time" "client_dns" "client_search" "client_gw"))

(define (ui-general-read)
  (catch/message
    (lambda()
      (let ((data (woo-read-first "/dhcp" 'ipv (form-value "ipv"))))
	(form-update-value-list *parameters* data)
	(form-update-visibility
	  '("client_dns" "client_search")
	  (not (woo-get-option data 'has_ddns)))))))

(define (ui-general-write)
  (catch/message
    (lambda()
      (apply woo-write "/dhcp"
             'general #t
			 'ipv (form-value "ipv")
             'language (form-value "language")
             (form-value-list *parameters*))
      (ui-general-read))))

(define (ui-static-read)
  (form-update-value "new_static_ip" "")
  (form-update-value "new_static_mac" "")
  (form-update-value "new_static_hname" "")
  (form-update-enum "static_name" (woo-list "/dhcp/avail_static" 'ipv (form-value "ipv"))))

;; note: iface, ip_start and ip_end are used for config validation
(define (ui-static-del)
  (catch/message
    (lambda()
      (apply woo-write "/dhcp"
             'static_del #t
			 'ipv (form-value "ipv")
             'language (form-value "language")
             (form-value-list '("static_name"
                                "iface" "ip_start" "ip_end")))
      (ui-static-read))))

;; note: iface, ip_start and ip_end are used for config validation
(define (ui-static-add)
  (catch/message
    (lambda()
      (apply woo-write "/dhcp"
             'static_add #t
			 'ipv (form-value "ipv")
             'language (form-value "language")
             (form-value-list '("new_static_ip" "new_static_mac" "new_static_hname"
                                "iface" "ip_start" "ip_end")))
      (ui-static-read))))

(define (ui-lease-read)
  (form-update-enum "lease_name" (woo-list "/dhcp/avail_lease" 'ipv (form-value "ipv"))))

(define (ui-lease-fix)
  (catch/message
    (lambda()
      (apply woo-write "/dhcp"
            'lease_fix #t
			'ipv (form-value "ipv")
            'language (form-value "language")
            (form-value-list '("lease_name"
                               "iface" "ip_start" "ip_end")))
      (ui-lease-read)
      (ui-static-read))))

(define (update-ui)
  (let* ((ipv (form-value "ipv"))
		 (iface-list (woo-list "/dhcp/avail_iface" 'ipv ipv 'language (form-value "language"))))
	(if (null? iface-list)
	  (begin
		(form-update-visibility "nostatic_page" #t)
		(form-update-visibility "static_page" #f))
	  (begin
		(form-update-visibility "client_gw" (string=? ipv "4"))
		;; lists
		(form-update-enum "iface" iface-list)
		;; read
		(ui-general-read)
		(ui-static-read)
		(ui-lease-read)))))

(define (init)
  (form-update-enum "ipv" (woo-list "/dhcp/ipv" 'language (form-value "language")))
  (form-update-value "ipv" "4")
  (form-update-enum "client_time" (woo-list "/dhcp/avail_time" 'language (form-value "language")))
  (update-ui)
  ;; buttons
  (form-bind "apply_button" "click" ui-general-write)
  (form-bind "reset_button" "click" ui-general-read)
  (form-bind "static_del_button" "click" ui-static-del)
  (form-bind "static_add_button" "click" ui-static-add)
  (form-bind "lease_fix_button" "click" ui-lease-fix)
  (form-bind "ipv" "change" update-ui)
  )

