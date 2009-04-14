(define-module (type dhcp-mac-address)
    :use-module (alterator woo)
    :export (type))

(define *hex* "[0-9a-fA-F]{2}")
(define *mac-address-regex-str* (string-append *hex* "(:" *hex* "){5}"))
(define *mac-address-regex* (make-regexp *mac-address-regex-str* regexp/extended))

(define (type v _)
  (or (and (string? v) (string-null? v))
      (and (string? v) (regexp-exec *mac-address-regex* v))
      (type-error (_ "invalid MAC address" "alterator-dhcp"))))
