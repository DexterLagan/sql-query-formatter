#lang racket/gui
(module+ test (require rackunit))

;;; purpose

; To format an SQL query for better readability

;;; consts

(define appname "SQL query prepper")

;;; defs

;; returns the clipboard's contents as string
(define (get-clipboard-text)
  (send the-clipboard get-clipboard-string 0))

;; sets the clipboard's contents given a string
(define (set-clipboard-text s)
  (send the-clipboard set-clipboard-string s 0))

;; macro that lets one compose functions with any number of parameters
;; each composed expression is essencially curried to accept one parameter 'x' through the use of internal lambdas
;; the result of each composed expression (evaluated right-to-left) is passed on to the next through 'x'
(define-syntax (composex stx)
  (syntax-case stx ()
    ((_ f1 ...)
     (with-syntax ([x-var (datum->syntax stx 'x)]) ; create a local variable so Racket doesn't scream it doesn't exist
       #'(compose1 (λ (x-var) f1) ...)))))         ; move each composed expression inside a lambda that uses our variable
 
; unit test:
(module+ test
  (check-equal? ((composex (string-replace x " " "-")
                           (string-downcase x)
                           (string-trim x)) " Naice Day ")
                "naice-day"))

;; formats a query with line breaks
(define (prep-sql-query query)
  ; preps an sql query
  ((composex
    (string-append "\"" x)
    (string-replace x ", "         ", \"+_\r\n\"")
    (string-replace x "AND "       "\"+_\r\n\"AND ")
    (string-replace x "FROM "      "\"+_\r\n\"FROM ")
    (string-replace x "WHERE "     "\"+_\r\n\"WHERE ")
    (string-replace x "ORDER "     "\"+_\r\n\"ORDER ")
    (string-replace x "LIMIT "     "\"+_\r\n\"LIMIT ")
    (string-replace x "(SELECT"   "\"+_\r\n\"(SELECT ")
    (string-replace x "DISTINCT "  "DISTINCT \"+_\r\n\"")
    (string-replace x "LEFT JOIN " "\"+_\r\n\"LEFT JOIN ")
    (string-append x "\"")
    (string-trim x))
   query))

;;; main

; get query from the clipboard, format it and place it back on the clipboard
(let ((query (get-clipboard-text)))
  (set-clipboard-text (prep-sql-query query)))

; EOF
