(define-module (type dhcp-dns-address)
    :use-module ((type ipv4-address)  :renamer (symbol-prefix-proc 'ipv4-address:))
    :export (type))

(define (type v _)
  (or (and (string? v) (string=? v "*"))
      (ipv4-address:type v _)))
