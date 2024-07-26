#lang racket
#|
            #####################################################
            ###  PLEASE DO NOT DISTRIBUTE SOLUTIONS PUBLICLY  ###
            #####################################################
|#
(provide (all-defined-out))
;; ^^^^^ DO NOT CHANGE ANY CODE ABOVE THIS LINE ^^^^^

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;now let  define struct 

(struct pair (left right) #:transparent)
;;create pair with value 1 and 3
(define p (pair 1 3))
;;this is to match pair and format the results
(match p
[(pair left right) (format "left: ~a, right: ~a" left right)])
;; Exercise 1
;;(define pair 'delete-me-after-defining-your-struct)
;;(define pair-left 'delete-me-after-defining-your-struct)
;;(define pair-right 'delete-me-after-defining-your-struct)

;; Exercise 1.a
;;this function it takes pair p and value also keeping right elemnt unchanged 
(define (pair-set-left p l) 'todo
(match p
[(pair left right) (pair l right)]))
;;this function it takes pair p and value also keeping left elemnt unchanged 
;; Exercise 1.b
(define (pair-set-right p r) 'todo
(match p
[(pair left right) (pair left r)]))
;;this creates new pair with the elemnts swapped, it swaps left and right elemnts or pairs of elemnts
;; Exercise 1.c
(define (pair-swap p) 'todo

(match p
[(pair left right) (pair right left)]))

;; Exercise 1.d
;; You can only use match* one time. You cannot use match.
;;this used match to organize two pairs, adding elemnts and creating new pairs with the reslt.
(define (pair-add p1 p2) 'todo
(match* [p1 p2]
[((pair lefthands1 righthands1) (pair lefthands2 righthands2 ))
(pair (+ lefthands1 lefthands2) (+ righthands1 righthands2))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 2.a
;;this is the name of function with selectfor lamda
(define (name first last) 'todo

(lambda (selectfor)
(cond
((eq? selectfor 'first )first)
((eq? selectfor 'last) last)
(else(error "its unable to select")))))

;; Exercise 2.b
;;this is to extract first-name
(define (first-name p) 'todo
(p 'first)) ;;
;; Exercise 2.c
;;this is to extract last-name 
(define (last-name p) 'todo
(p 'last))

;; Exercise 2.d
;;this creates full name by concatenating, since we using string-append
(define (full-name p) 'todo
(string-append (first-name p) " " (last-name p)))

;; Exercise 2.e
;;this creates initial from first and last name by stracting the charachter
(define (initials p) 'todo
(string-append (substring (first-name p) 0 1 ) (substring (last-name p) 0 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3
;;this is to find max elemnt in list 
(define (max-from n l) 'todo
(match l
[ '() n]
[(cons a b) (max-from (max n a) b)]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 4
;;this finds minimum elmnt
(define (min-from n l) 'todo
(match l
[ '() n]
[(cons a b) (min-from (min n a) b)]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 5: revisit Exercise 3 and Exercise 4
(define (min-and-max open n l)
(match l 
[ '() n]
[(cons a b) (min-and-max open (open n a) b)]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 6
;;this counts the number of elemnts
(define (count l) 'todo
(match l
['() 0]
[(cons h a)(+ 1 (count a))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 7
;;this calculates the sum or tot
(define (sum l) 'todo
(match l
['() 0]
[(cons h smth)(+ h (sum smth))]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 8
;;this is used to count the occurance of x in a list l
(define (occurrences x l) 'todo
(match l
['() 0]
[(cons n tails)
(cond
[(eq? x n) (+ 1 (occurrences x tails))]
[else (occurrences x tails)])]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 9
;;this part used to calculates euclidean norm
(define (norm l) 'todo
;;calculates the square of numbers means x*x
(define (sqr_square x) (* x x))
(define (sum l)
(match l
['() 0]
[(cons h tot) (+ h (sum tot))]
))
;;calculates the square root of sum
(sqrt (sum (map sqr_square l))))


;;cite

;;I did this homework from what i learned from my professor and his lectures (week3_parctices codes, lecture6_slides.zip and others)
;;https://umassboston.instructure.com/courses/229/modules