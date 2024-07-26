#lang errortrace racket
#|
            ######################################################
            ###  PLEASE DO NOT DISTRIBUTE TEST CASES PUBLICLY  ###
            ###         SHARING IN THE FORUM ENCOURAGED        ###
            ######################################################

  You are encouraged to share your test cases in the course forum, but please
  do not share your test cases publicly (eg, GitHub), as that stops future
  students from learning how to write test cases, which is a crucial part of
  this course.
|#
(provide (all-defined-out))
(require "hw6-util.rkt")


(define/contract (quote-frame frm)
  (-> frame? list?)
  (define hdl (cond [(frame-parent frm) (quote-handle (frame-parent frm))] [else #f]))
  (define elems (quote-hash (frame-locals frm) quote-term quote-term symbol<?))
  (if hdl (cons hdl elems) elems))

(define/contract (parse-mem node)
  (-> any/c heap?)
  (heap (parse-hash node parse-handle parse-frame)))

(define/contract (quote-handle h)
  (-> handle? symbol?)
  (string->symbol (format "E~a" (handle-id h))))

(define (quote-hash map quote-key quote-val lt?)
  (define (for-each k v)
    (cons (quote-key k) (quote-val v)))
  (define (<? x y)
    (lt? (car x) (car y)))
  (sort (hash-map map for-each) <?))

(define (quote-mem mem)
  (-> heap? list?)
  (quote-hash (heap-data mem) quote-handle quote-frame symbol<?))

(define/contract (parse-handle node)
  (-> symbol? handle?)
  (handle (string->number (substring (symbol->string node) 1))))

(define (parse-term node)
  (match node
    [(? symbol?) (d:variable node)]
    [(? real?) (d:number node)]
    [(list 'define (list x y) t ...)
      (d:define (d:variable x) (d:lambda (d:variable y) (parse-seq t)))]
    [(list 'define x e) (d:define (d:variable x) (parse-term e))]
    [(list 'lambda (list x) t ...) (d:lambda (d:variable x) (parse-seq t))]
    [(list 'closure E (list 'lambda (list x) t ...))
      (d:closure (parse-handle E) (d:variable x) (parse-seq t))]
    [(list 'void) (d:void)]
    [(list f e) (d:apply (parse-term f) (parse-term e))]))

(define (parse-seq t)
  (match t
    [(list t) (parse-term t)]
    [(list h t ...) (d:seq (parse-term h) (parse-seq t))]))

(define (quote-term t)
  (match t
    [(d:seq _ _) (quote-seq t)]
    [(d:lambda x (? d:seq? t))
      (cons 'lambda
        (cons (list (quote-term x))
          (quote-seq t)))]
    [(d:lambda x t)
      (list 'lambda (list (quote-term x)) (quote-term t))]
    [(d:apply ef ea) (list (quote-term ef) (quote-term ea))]
    [(d:number n) n]
    [(d:variable x) x]
    [(d:void) '(void)]
    [(d:define f (d:lambda x t))
      (cons 'define
        (cons (list (quote-term f) (quote-term x))
          (quote-seq t)))
    ]
    [(d:define x e) (list 'define (quote-term x) (quote-term e))]
    [(d:closure env x e)
      (list 'closure (quote-handle env)
        (quote-term (d:lambda x e)))]
  )
)

(define (quote-seq t)
  (match t
    [(d:seq x y) (cons (quote-term x) (quote-seq y))]
    [_ (list (quote-term t))]))

(define/contract (parse-frame node)
  (-> list? frame?)
  (define (on-handle node)
    (cond [(boolean? node) node]
          [else (parse-handle node)]))
  (define hd (if (or (empty? node) (pair? (first node))) #f (first node)))
  (define elems (if hd (rest node) node))
  (frame (on-handle hd) (parse-hash elems parse-term parse-term)))

(define empty-heap (heap (hash)))
(define root-frame (frame #f (hash)))
(define root-alloc (heap-alloc empty-heap root-frame))
(define/contract root-environ handle? (eff-result root-alloc))
(define root-mem (eff-state root-alloc))


(define (parse-hash node parse-key parse-val)
  (define (for-each pair)
    (cons (parse-key (car pair)) (parse-val (cdr pair))))
  (make-immutable-hash (map for-each node)))
