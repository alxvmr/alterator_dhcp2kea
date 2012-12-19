(define-module (type dhcp-dns-address)
    :use-module ((type ip-address)  :renamer (symbol-prefix-proc 'ip-address:))
    :export (type))

(define (type v _)
  (or (and (string? v) (string=? v "*"))
	  (ip-address:type v _)))
