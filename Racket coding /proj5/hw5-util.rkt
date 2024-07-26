#lang typed/racket
#|
    ===> PLEASE DO NOT DISTRIBUTE THIS FILE <===

  You are encouraged to read through the file for educational purposes,
  but you should not make this file available to a 3rd-party, e.g.,
  by making the file available in a website.

  Students are required to adhere to the University Policy on Academic
  Standards and Cheating, to the University Statement on Plagiarism and the
  Documentation of Written Work, and to the Code of Student Conduct as
  delineated in the catalog of Undergraduate Programs. The Code is available
  online at: http://www.umb.edu/life_on_campus/policies/code/

|#

(provide (all-defined-out))

;; ---------------------------------------------------------------------------
;; Language S, for substitution

(define-type s:value (U s:number s:lambda))
(define-type s:expression (U s:value s:variable s:apply))

(struct s:number ([value : Number]) #:transparent)
(struct s:variable ([name : Symbol]) #:transparent)
(struct s:lambda ([param : s:variable] [body : s:expression]) #:transparent)
(struct s:apply ([func : s:expression] [arg : s:expression]) #:transparent)

(: s:value? (-> Any Boolean : s:value))
(define (s:value? e)
  (or (s:number? e) (s:lambda? e)))

(: s:expression? (-> Any Boolean : s:expression))
(define (s:expression? e)
  (or (s:value? e) (s:variable? e) (s:apply? e)))

;; ---------------------------------------------------------------------------
;; Language E, for environment

(define-type e:value (U e:number e:closure))
(define-type e:expression (U e:value e:variable e:apply e:lambda))

(define-type-alias e:environ (Immutable-HashTable e:variable e:value))

(struct e:variable ([ name : Symbol ]) #:transparent)
(struct e:number ([value : Number]) #:transparent)
(struct e:closure (
    [env : e:environ]
    [param : e:variable]
    [body : e:expression]
  )
  #:transparent
)

(struct e:lambda (
    [param : e:variable]
    [body : e:expression]
  )
  #:transparent
)

(struct e:apply (
    [func : e:expression]
    [arg : e:expression]
  ) #:transparent
)

(: e:env-get (-> e:environ e:variable e:value))
(define (e:env-get env x)
  (hash-ref env x))

(: e:env-put (-> e:environ e:variable e:value e:environ))
(define (e:env-put env x v)
  (hash-set env x v))

(: e:value? (-> Any Boolean : e:value))
(define (e:value? e)
  (or (e:number? e) (e:closure? e)))

(: e:expression? (-> Any Boolean : e:expression))
(define (e:expression? e)
  (or (e:value? e) (e:variable? e) (e:apply? e) (e:lambda? e)))
