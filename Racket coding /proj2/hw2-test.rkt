#lang racket
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
(require "hw2.rkt")
(require rackunit)
(require rackunit/text-ui)
(define-check (check-real? given expected)
  (define delta 0.00000001)
  (define b (max (abs given) (abs expected)))
  (cond
    [(or (equal? expected given) (equal? (inexact->exact b) 0)) (void)]
    [else
      (define r
        (/ (abs (- expected given)) b))
      (if
        (<= r delta) (void)
        (check-equal? given expected))]))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tests start here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-1
  (test-suite "Exercise 1"
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 1: pair"
      (check-equal? (pair 1 2)  (pair 1 2))
    )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 1: pair-left"
      (check-equal? (pair-left (pair 1 2))  1)
    )
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 1: pair-right"
      (check-equal? (pair-right (pair 1 2))  2)
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-1.a
  (test-case "Exercise 1.a: pair-set-right"
    (check-equal? (pair-set-right (pair 1 2) 10) (pair 1 10))
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-1.b
  (test-case "Exercise 1.b: pair-set-left"
    (check-equal? (pair-set-left (pair 1 2) 10) (pair 10 2))
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-1.c
  (test-case "Exercise 1.c: pair-swap"
    (check-equal? (pair-swap (pair 1 2)) (pair 2 1))
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-1.d
  (test-case "Exercise 1.d: pair-add"
    (check-equal? (pair-add (pair 1 2) (pair 3 4)) (pair 4 6))
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-2.b
  (test-case "Exercise 2.b: first-name"
    (check-equal? (first-name (name "foo" "bar")) "foo")
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-2.c
  (test-case "Exercise 2.c: last-name"
    (check-equal? (last-name (name "foo" "bar")) "bar")
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-2.d
  (test-case "Exercise 2.d: full name"
    (check-equal? (full-name (name "foo" "bar")) "foo bar")
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-2.e
  (test-case "Exercise 2.e: initials"
    (check-equal? (initials (name "foo" "bar")) "fb")
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-3
  (test-case "Exercise 3: max-from"
    (check-equal? (max-from 0 (list 1 2 3)) 3)
    (check-equal? (max-from 4 (list 1 2 3)) 4)
    (check-equal? (max-from 0 (list)) 0)
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-4
  (test-case "Exercise 4: min-from"
    (check-equal? (min-from 0 (list 1 2 3)) 0)
    (check-equal? (min-from 4 (list 1 2 3)) 1)
    (check-equal? (min-from 0 (list)) 0)
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-6
  (test-case "Exercise 6: count"
    (check-equal? (count (list)) 0)
    (check-equal? (count (list 1)) 1)
    (check-equal? (count (list 1 2)) 2)
    (check-equal? (count (list 2 1 0)) 3)
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-7
  (test-case "Exercise 7: sum"
    (check-equal? (sum (list)) 0)
    (check-equal? (sum (list 1)) 1)
    (check-equal? (sum (list 1 2)) 3)
    (check-equal? (sum (list 1 2 3)) 6)
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-8
  (test-case "Exercise 8: occurrences"
    (check-equal? (occurrences 0 (list)) 0)
    (check-equal? (occurrences 0 (list 1)) 0)
    (check-equal? (occurrences 0 (list 1 2)) 0)
    (check-equal? (occurrences 0 (list 2  0 1 0)) 2)
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-test-suite test-9
  (test-case "Exercise 9: norm"
    (check-real? (norm (list 1 2 3)) (sqrt (+ 1 4 9)))
    (check-real? (norm (list 2 2 2 2)) (sqrt (+ 4 4 4 4)))
    (check-real? (norm (list)) 0)
  )
)
(define tests
  (test-suite "Tests"
    ; Comment out a line to disable a test
    test-1
    test-1.a
    test-1.b
    test-1.c
    test-1.d
    test-2.b
    test-2.c
    test-2.d
    test-2.e
    test-3
    test-4
    test-6
    test-7
    test-8
    test-9
  )
)

;; To run the tests in the console uncomment the following line
;;(exit (run-tests tests 'verbose))