(define-module (ui kea static ajax)
    :use-module (alterator ajax)
    :use-module (alterator woo)
    :export (init))

(define (ui-read)
  (let ((mac (form-value "mac"))
		(ipv (form-value "ipv")))
    (form-update-value "mac" mac)
    (form-update-value-list
      '("new_static_ip" "new_static_hname")
      (woo-read-first "/kea/static" 'mac mac 'ipv ipv))))

(define (ui-write)
  (catch/message
    (lambda()
      (apply woo-write "/kea/static"
             (form-value-list '("ipv" "language" "mac" "new_static_ip" "new_static_hname")))
      (form-replace "/kea"))))

(define (init)
  (form-update-enum "ipv" (woo-list "/kea/ipv" 'language (form-value "language")))
  (form-update-value "ipv" "4")
  (ui-read)
  (form-bind "apply" "click" ui-write)
  (form-bind "reset" "click" ui-read)
  (form-bind "ipv" "change" ui-read))
