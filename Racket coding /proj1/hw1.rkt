#lang racket
#|
    ===> PLEASE DO NOT DISTRIBUTE THE SOLUTIONS PUBLICLY <===

  We ask that solutions be distributed only locally -- on paper, on a
  password-protected webpage, etc.

  Students are required to adhere to the University Policy on Academic
  Standards and Cheating, to the University Statement on Plagiarism and the
  Documentation of Written Work, and to the Code of Student Conduct as
  delineated in the catalog of Undergraduate Programs. The Code is available
  online at: http://www.umb.edu/life_on_campus/policies/code/

                    * * * ATTENTION! * * *

  Every solution submitted to our grading server is automatically compared
  against a solution database for plagiarism, which includes every solution
  from every student in past semesters.

  WE FOLLOW A ZERO-TOLERANCE POLICY: any student breaking the Code of Student
  Conduct will get an F in this course and will be reported according to
  Section II Academic Dishonesty Procedures.

|#

;; Please, do not remove this line and do not change the function names,
;; otherwise the grader will not work and your submission will get 0 points.
(provide (all-defined-out))

;; Note: i coded for ex1 13.2 and 6.8 as multiplication not as decimal

(define 
ex1 (+ (- 7 (* 13 2)) (+ 8 (* 6 8)))) ;;this is when we do for the second question according to the instruction

;;;;;;;since its is the same with 
;;define ex2
;;(list
;;(* 3.14159 (* 10 10))
;;(* 3.14159 100)
;;314.159))
(define ex2
  (list
  ;; (+ (- 7 (* 13 2)) (+ 8 ( * 6 8 )
  ;; ) ) ;;the machine starts calculating from the right to left
   (+ (- 7 26) (+ 8 48)) ;;the output will be 37
   (+ -19 56) ;;the output will be 37
   37)) ;;the output will be 37
   
(define (ex3 x y)
  (> (- (- x y)
      (* 12 x)) (- (- 3 2) x)))

;; Constructs a tree from two trees and a value
(define (tree left value right)
  (list left value right)
  )

;; Constructs a tree with a single node
(define (tree-leaf value)
  ;;now we create a leaf node for binary tree with empty right and left subtree
  (list '() value '()))

;; Accessors

;; elements holding the node value
(define (tree-left self)
  'todo (first self))

(define (tree-value self)
  'todo (second self))

(define (tree-right self) 'todo ( third self))

;; Copies the source and updates one of the fields
(define (tree-set-value self value) 'todo
  ;;now updating the left tree subtree of self
  (list (tree-left self) value (tree-right self)))
;;then update 'self' with the specified 'left' 
(define (tree-set-left self left)
  (list left (tree-value self) (tree-right self)))
;;now update self with the specified 'right' 
(define (tree-set-right self right)
  (list (tree-left self) (tree-value self) right))

;; Function that inserts a value in a BST
(define (bst-insert self value) 'todo
 (cond[(equal?  empty self) (list(list) value (list))]
       [(equal? value (tree-value self)) (tree-set-value self value) ]
       ;;the belows checks that if the value is less than value stored in bst self and if true recusrively inserts value to the left else right
       [(< value (tree-value self)) (tree-set-left self (bst-insert (tree-left self) value))]
       [else (tree-set-right self (bst-insert (tree-right self) value ))]))

;; lambda
(define (lambda? node) 'todo
  ;;checking of the list have more than 2 elemnt
  (and (list? node) (> (length node) 2)
       ;;check if 'lambda for first elemnt is the symbol 'lambda and node is not empty list
   (equal? 'lambda (first node)) (not (empty? node))
   (list? (second node))
   ;;check all elments of list if symbol is in second node
   (andmap symbol? (second node))))
   
   
(define
  (lambda-params node) 'todo (second node))
(define
  (lambda-body node) 'todo (rest (rest node)))

;; apply
(define (apply? l)'todo
  ;;this is to check if l is non empty list
  (and (list? l)
       (> (length l) 0) ))
       ;;now let we retrieve the function from 'node'
(define (apply-func node) 'todo (first node ))
  ;;then after it retrieve 'node'
(define (apply-args node) 'todo (rest node))

;; define
(define (define? node) 'todo
  (or (and (equal? (list? node) #t) (= (length node) 3)
       (equal? (first node) 'define) (symbol? (second node)))
      ;; this is to check if node have atleast two elements
  (and (list? node) (>= (length node) 2) (list? (second node))
  (equal? (first node) 'define) (map symbol? (second node))
       (not (empty? (second node)))
       ;;this used to check if second element of node is a list 
       (list? (second node)))))
( define? (quote (define x y)))

(define (define-basic? node) 'todo
 (and (equal? (list? node) #t) (= (length node) 3)
      ;;check define is equal with first elements
      (equal? (first node) 'define) (symbol? (second node))
      )
  )
(define (define-func? node)
(and (list? node) (> (length node) 2)
      (equal? 'define (first node)) (list? (second node))
(not (empty? (second node)))
;; this used to check if all elemtns in second element of node are symbols
(map symbol? (second node ))))


;;All of this code is from What I learn from my professor and from google sources https://docs.racket-lang.org/index.html