(define-module (ui dhcp static ajax)
    :use-module (alterator ajax)
    :use-module (alterator woo)
    :export (init))

(define (ui-read)
  (let ((mac (form-value "mac")))
    (form-update-value "mac" mac)
    (form-update-value-list
      '("new_static_ip" "new_static_hname")
      (woo-read-first "/dhcp/static" 'mac mac))))

(define (ui-write)
  (catch/message
    (lambda()
      (apply woo-write "/dhcp/static"
             (form-value-list '("language" "mac" "new_static_ip" "new_static_hname")))
      (form-replace "/dhcp"))))

(define (init)
  (ui-read)
  (form-bind "apply" "click" ui-write)
  (form-bind "reset" "click" ui-read))
