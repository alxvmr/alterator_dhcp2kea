(define-module (ui dhcp ajax)
    :use-module (alterator ajax)
    :use-module (alterator woo)
    :export (init))

(define (init)
    (form-update-visibility
	'("client_dns" "client_search")
	(not (woo-get-option (woo-read-first "/dhcp") 'has_ddns))))
