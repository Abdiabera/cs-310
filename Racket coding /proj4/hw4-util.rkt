#lang typed/racket
#|
    ===> PLEASE DO NOT DISTRIBUTE SOLUTIONS NOR TESTS PUBLICLY <===

   We ask that solutions be distributed only locally -- on paper, on a
   password-protected webpage, etc.

   Students are required to adhere to the University Policy on Academic
   Standards and Cheating, to the University Statement on Plagiarism and the
   Documentation of Written Work, and to the Code of Student Conduct as
   delineated in the catalog of Undergraduate Programs. The Code is available
   online at: http://www.umb.edu/life_on_campus/policies/code/

|#

(provide (all-defined-out))

; Defines an infinite stream, which is parameterized in Elem
; An infinite stream is a function that takes 0 args and
; returns adding one element to the stream of type Elem.
(define-type (stream Elem)
  (-> (stream-add Elem))
)
(struct [T] stream-add (
  [first : T]
  [rest : (stream T)]
  )
  #:transparent
)

(define-type set (-> (U set-empty set-add)))
(struct set-empty () #:transparent)
(struct set-add ([first : String] [rest : set]) #:transparent)

(define-type r:value r:number)
(define-type r:expression (U r:value r:apply r:variable))
(struct r:number ([value : Number]))
(struct r:variable ([name : Symbol]))
(struct r:apply ([func : r:expression] [args : (Listof r:expression)] ))

(: join (-> String (Listof String) String))
(define (join sep l)
  (match l
    [(list) ""]
    [(list h l ...)
          (foldl (lambda ([h : String] [r : String]) (string-append r sep h)) h l) ]))

(: r:eval-builtin (-> Symbol (-> Number * Number)))
(define (r:eval-builtin sym)
  (match sym
    ['+ +]
    ['* *]
  )
)
