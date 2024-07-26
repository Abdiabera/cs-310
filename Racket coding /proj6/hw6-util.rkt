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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The heap data-structure

(struct handle ([id : Number]) #:transparent)
(struct [T] heap ([data : (Immutable-HashTable handle T)]) #:transparent)
(struct [S T] eff ([state : S] [result : T]) #:transparent)

(: heap-alloc (All [T] (-> (heap T) T (eff (heap T) handle))))
(define (heap-alloc h v)
  (define data (heap-data h))
  (define new-id (handle (hash-count data)))
  (define new-heap (heap (hash-set data new-id v)))
  (eff new-heap new-id))

(: heap-get (All [T] (-> (heap T) handle T)))
(define (heap-get h k)
  (hash-ref (heap-data h) k))

(: heap-put (All [T] (-> (heap T) handle T (heap T))))
(define (heap-put h k v)
  (define data (heap-data h))
  (cond
    [(hash-has-key? data k) (heap (hash-set data k v))]
    [else (error "Unknown handle!")]))

;; Values
(define-type d:value (U d:void d:number d:closure))
(struct d:void () #:transparent)
(struct d:number ([value : Number]) #:transparent)
(struct d:closure (
    [env : handle]
    [param : d:variable]
    [body : d:term]
  )
  #:transparent
)

(define-type d:expression (U d:value d:variable d:apply d:lambda))
(struct d:lambda ([param : d:variable] [body : d:term]) #:transparent)
(struct d:variable ([name : Symbol]) #:transparent)
(struct d:apply ([func : d:expression] [arg : d:expression]) #:transparent)

(: d:expression? (-> Any Boolean : d:expression))
(define (d:expression? e)
  (or (d:value? e)
      (d:variable? e)
      (d:apply? e)
      (d:lambda? e)))

;; Terms
(define-type d:term (U d:expression d:define d:seq))
;; (define (d:term? t)
;;   (or (d:expression? t)
;;       (d:define? t)
;;       (d:seq? t)))
(struct d:define ([var : d:variable] [body : d:expression]) #:transparent)
(struct d:seq ([fst : d:term] [snd : d:term]) #:transparent)

(: d:value? (-> Any Boolean : d:value))
(define (d:value? v)
  (or (d:number? v)
      (d:void? v)
      (d:closure? v)))

(struct frame (
    [parent : (Option handle)]
    [locals : (Immutable-HashTable d:variable d:value)]
  ) #:transparent
)
;; (define (frame-push parent var val)
;;   (frame parent (hash var val)))
(: frame-put (-> frame d:variable d:value frame))
(define (frame-put frm var val)
  (frame (frame-parent frm) (hash-set (frame-locals frm) var val)))

(: frame-get (-> frame d:variable (Option d:value)))
(define (frame-get frm var)
  (hash-ref (frame-locals frm) var #f))

(define-type memory (heap frame))

(: environ-put (-> memory handle d:variable d:value memory))
(define (environ-put mem env var val)
  (define new-frm (frame-put (heap-get mem env) var val))
  (heap-put mem env new-frm))

;; The push operation
(: environ-push (-> memory handle d:variable d:value (eff memory handle)))
(define (environ-push mem env var val)
  (define new-frame (frame env (hash var val)))
  (heap-alloc mem new-frame))

;; The Get operation
(: environ-get (-> memory handle d:variable d:value))
(define (environ-get mem env var)
  (: environ-get-aux (-> handle (Option d:value)))
  (define (environ-get-aux env)
    (define frm (heap-get mem env))    ;; Load the current frame
    (define parent (frame-parent frm))  ;; Load the parent
    (define result (frame-get frm var)) ;; Lookup locally
    (cond
      [result result] ;; Result is defined, then return it
      [parent (environ-get-aux parent)] ; If parent exists, recurse
      [else #f]))
  (define res (environ-get-aux env))
  ; Slight change from the slides for better error reporting
  (when (not res)
    (: on-elem (-> (Pairof handle frame) String))
    (define (on-elem x)
      (define l (car x))
      (define r (cdr x))
      (format "(E~a . ~a)" (handle-id l) r))
    (error (format "Variable ~a was NOT found in environment ~a\n~a" var env
      (map on-elem (hash->list (heap-data mem)))))
  )
  res)

