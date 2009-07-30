(define-module (ui dhcp ajax)
    :use-module (alterator ajax)
    :use-module (alterator woo)
    :export (init))

(define *parameters* '("daemon" "iface" "ip_start" "ip_end" "client_time" "client_dns" "client_search" "client_gw"))

(define (ui-general-read)
  (catch/message
    (lambda()
      (let ((data (woo-read-first "/dhcp")))
	(form-update-value-list *parameters* data)
	(form-update-visibility
	  '("client_dns" "client_search")
	  (not (woo-get-option data 'has_ddns)))))))

(define (ui-general-write)
  (catch/message
    (lambda()
      (apply woo-write "/dhcp"
             'general #t
             'language (form-value "language")
             (form-value-list *parameters*))
      (ui-general-read))))

(define (ui-static-read)
  (form-update-value "new_static_ip" "")
  (form-update-value "new_static_mac" "")
  (form-update-value "new_static_hname" "")
  (form-update-enum "static_name" (woo-list "/dhcp/avail_static")))

;; note: iface, ip_start and ip_end are used for config validation
(define (ui-static-del)
  (catch/message
    (lambda()
      (apply woo-write "/dhcp"
             'static_del #t
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
             'language (form-value "language")
             (form-value-list '("new_static_ip" "new_static_mac" "new_static_hname"
                                "iface" "ip_start" "ip_end")))
      (ui-static-read))))

(define (ui-lease-read)
  (form-update-enum "lease_name" (woo-list "/dhcp/avail_lease")))

(define (ui-lease-fix)
  (catch/message
    (lambda()
      (apply woo-write "/dhcp"
            'lease_fix #t
            'language (form-value "language")
            (form-value-list '("lease_name"
                               "iface" "ip_start" "ip_end")))
      (ui-lease-read)
      (ui-static-read))))

(define (init)
  (let ((iface-list (woo-list "/dhcp/avail_iface" 'language (form-value "language"))))
    (if (null? iface-list)
        (begin
         (form-update-visibility "nostatic_page" #t)
         (form-update-visibility "static_page" #f))
        (begin
	  ;; lists
	  (form-update-enum "iface" iface-list)
	  (form-update-enum "client_time" (woo-list "/dhcp/avail_time" 'language (form-value "language")))
	  ;; read
	  (ui-general-read)
	  (ui-static-read)
	  (ui-lease-read)
	  ;; buttons
	  (form-bind "apply_button" "click" ui-general-write)
	  (form-bind "reset_button" "click" ui-general-read)
	  (form-bind "static_del_button" "click" ui-static-del)
	  (form-bind "static_add_button" "click" ui-static-add)
	  (form-bind "lease_fix_button" "click" ui-lease-fix)
	  ))))

