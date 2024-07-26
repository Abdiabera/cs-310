#lang racket
#|
Abdi Abera
            #####################################################
            ###  PLEASE DO NOT DISTRIBUTE SOLUTIONS PUBLICLY  ###
            #####################################################

  Copy your solution of HW1 as file "hw1.rkt". The file should be in the same
  directory as "hw2.rkt" and "ast.rkt".
|#
(require "ast.rkt")
(require "hw1.rkt")
(require rackunit)

(provide (all-defined-out))
;; ^^^^^ DO NOT CHANGE ANY CODE ABOVE THIS LINE ^^^^^


;; Exercise 1
;; this is used to find min elemnt in a list since its using min-from
(define (min-from n l) 
(foldr (lambda (h res)
(min h res)) n  l))

;; Exercise 2
;;this is to count number of an elemnt
(define (count l) 
(foldr (lambda (h res)
(+ 1 res)) 0 l))

;; Exercise 3
;;calulating sum
(define (sum l) 
(foldr (lambda (h res)
(+ h res)) 0 l
)
)

;; Exercise 4
;; this will count occurences of numbers in a list
(define (occurrences n l) 
(foldl (lambda (h res)
;;this will check if h is equal with n 
(if (= h n)
;;this will increment if there is a match or if there is not mtach, keep count unchanged.
(+ 1 res) res)) 0 l))

;; Exercise 5
;; this will add given string to to the beggining of each string in a list
(define (prefix s l) 
;;this will takes string-s in the list
(map (lambda (string-s)
;; this will add string 's' with string-s
(string-append s string-s))
l)
)

;; Exercise 6
;; this will interleave elemnts from l1 and l2
(define (interleave l1 l2)
  (match l1 ;; this checks l1 if it matchs
    [(list)
      l2]
    [(list head l1 ...)
    ;;this used to combine  l1 with the result of recursively interleaving the rest of the lists
      (cons head (interleave l2 l1))]))

;; Exercise 7
;;inetersperse takes l and v list
(define (intersperse l v) 
;;in this the helper function used wich takes an element 'elementof'
(define (step elemnetof accum)
;;if accum is empty 
(if (null? accum)
;;create list of elemnetof
(list elemnetof)
(cons elemnetof (cons v accum))))
(foldr step '() l)
)
;; Exercise 8
;;this will take AST node
(define (parse-ast node)
  (define (make-define-func node) 
  ;;defining with name and parameters then parsing the function recurisvely 
  (r:define (make-variable (first (second node)))
  (r:lambda (map make-variable (rest (second node)))
  (map parse-ast (rest (rest node))))))
;; now defining make-define-basic
  (define (make-define-basic node) 
;; now creates parameters and parse values recursively
  (r:define (parse-ast (second node))
  (parse-ast (first (rest ( rest node)))
  )
  )
  )
  ;;defines make lambda
  (define (make-lambda node) 
  ;; this is to create lamda expression with two argument
  (r:lambda (map make-variable (second node))
  (map parse-ast (rest (rest node))
  )
  )
  )
;; define make-apply
  (define (make-apply node) 
  ;; now check if the node is alist
   (if (list? node)
   (cond
   ;; if node is empty then return empty list
   [(empty? node) (list)]
   ;; this will apply functions recursively
   [(apply? node) (r:apply (parse-ast (first node))
   (map parse-ast (rest node)))]
   [else (map parse-ast node)])
   (list (parse-ast node))))

;; this to define make-number to handle numeric
  (define (make-number node) 
  ;; returns  numbers
  (r:number node))

  (define (make-variable node) 
  ;; returns variables 
  (r:variable node)
  )

  (cond
    [(define-basic? node) (make-define-basic node)]
    [(define-func? node) (make-define-func node)]
    [(symbol? node) (make-variable node)]
    [(real? node) (make-number node)]
    [(lambda? node) (make-lambda node)]
    [else (make-apply node)]))
