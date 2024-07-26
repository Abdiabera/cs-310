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
(require rackunit)
(require rackunit/text-ui)
(require "ast.rkt")
(require "hw3.rkt")

(define-test-suite test-1
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 1. min-from"
      (check-equal? (min-from 0 (list 1 2 3)) 0)
      (check-equal? (min-from 4 (list 1 2 3)) 1)
      (check-equal? (min-from 0 (list)) 0)
    )
)

(define-test-suite test-2
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 2. count"
      (check-equal? (count (list)) 0)
      (check-equal? (count (list 1)) 1)
      (check-equal? (count (list 1 2)) 2)
      (check-equal? (count (list 2 1 0)) 3)
    )
)

(define-test-suite test-3
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 3. sum"
      (check-equal? (sum (list)) 0)
      (check-equal? (sum (list 1)) 1)
      (check-equal? (sum (list 1 2)) 3)
      (check-equal? (sum (list 1 2 3)) 6)
    )
)

(define-test-suite test-4
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 4. occurrences"
      (check-equal? (occurrences 0 (list)) 0)
      (check-equal? (occurrences 0 (list 1)) 0)
      (check-equal? (occurrences 0 (list 1 2)) 0)
      (check-equal? (occurrences 0 (list 2  0 1 0)) 2)
    )
)

(define-test-suite test-5
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 5. prefix"
      (check-equal?
        (prefix "a" (list "c" "d" "e"))
        (list "ac" "ad" "ae"))
      (check-equal?
        (prefix "foo" (list "" "bar"))
        (list "foo" "foobar"))
      (check-equal?
        (prefix "foo" (list))
        (list))
    )
)
(define-test-suite test-6
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 6. interleave"
      (check-equal?
        (interleave (list 1 2 3 4) (list "a" "b"))
        (list 1 "a" 2 "b" 3 4))
      (check-equal?
        (interleave (list "a" "b") (list 1 2 3 4))
        (list "a" 1 "b" 2 3 4))
      (check-equal?
        (interleave (list) (list 1 2 3 4))
        (list 1 2 3 4))
      (check-equal?
        (interleave (list 1 2 3 4) (list))
        (list 1 2 3 4))
      (check-equal?
        (interleave (list) (list))
        (list))
    )
)
(define-test-suite test-7
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 7. intersperse"
      (check-equal? (intersperse (list 1 2 3) 0) (list 1 0 2 0 3))
      ; In this case we are adding a symbol instead of a number:
      (check-equal? (intersperse (list 1 2) 'x) (list 1 'x 2))

      ; To intersperse we need to have at least 2 elements in the list
      (check-equal? (intersperse (list 1) 9) (list 1))
      (check-equal? (intersperse (list) 10) (list))
    )
)
(define-test-suite test-8-1
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 8. parse-ast"

      (check-equal? (parse-ast 'x) (r:variable 'x))

      (check-equal? (parse-ast '10) (r:number 10))
  )
)
(define-test-suite test-8-2
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 8. parse-ast"
      (check-equal?
        (parse-ast '(lambda (x) x))
        (r:lambda (list (r:variable 'x)) (list (r:variable 'x))))
    )
)

(define-test-suite test-8-3
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 8. parse-ast"
      (check-equal?
        (parse-ast '(define (f y) (+ y 10)))
        (r:define
          (r:variable 'f)
          (r:lambda
            (list (r:variable 'y))
            (list (r:apply (r:variable '+) (list (r:variable 'y) (r:number 10)))))))
      (check-equal?
        (parse-ast '(define (f) (+ 2 3 4)))
        (r:define (r:variable 'f)
          (r:lambda '()
            (list (r:apply (r:variable '+) (list (r:number 2) (r:number 3) (r:number 4)))))))

      (check-equal?
        (parse-ast '(define (f) 10))
        (r:define (r:variable 'f)
          (r:lambda '() (list (r:number 10)))))

      (check-equal?
        (parse-ast '(define (f) (define x 3) x))
        (r:define (r:variable 'f)
          (r:lambda '()
            (list (r:define (r:variable 'x) (r:number 3)) (r:variable 'x)))))

      (check-equal?
        (parse-ast '(define (f x y) (+ x y 10)))
        (r:define (r:variable 'f)
          (r:lambda (list (r:variable 'x) (r:variable 'y))
            (list (r:apply (r:variable '+) (list (r:variable 'x) (r:variable 'y) (r:number 10)))))))

      (check-equal?
        (parse-ast '(define (f x y) (+ x (- y 2) 10)))
        (r:define
          (r:variable 'f)
          (r:lambda (list (r:variable 'x) (r:variable 'y))
            (list
              (r:apply (r:variable '+)
                (list (r:variable 'x)
                      (r:apply (r:variable '-) (list (r:variable 'y) (r:number 2)))
                      (r:number 10)))))))

  )
)

(define-test-suite test-8-4
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 8. parse-ast"
      (check-equal?
      (parse-ast (quote (lambda (x) (define y 10) y)))
      (r:lambda
        (list (r:variable 'x))
        (list
          (r:define
            (r:variable 'y)
            (r:number 10)
          )
          (r:variable 'y))))
  )
)

(define-test-suite test-8-5
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    (test-case "Exercise 8. parse-ast"
      (check-equal?
        (parse-ast '(+ 3))
        (r:apply (r:variable '+) (list (r:number 3))))

      (check-equal?
        (parse-ast '(x))
        (r:apply (r:variable 'x) (list)))

      (check-equal?
        (parse-ast '(1))
        (r:apply (r:number 1) (list)))

      (check-equal?
        (parse-ast '((lambda () 10)))
        (r:apply
          (r:lambda '() (list (r:number 10)))
          (list)))

      (check-equal?
      (parse-ast '(define (function x y)
                    ((lambda (x) (x 5)) ((lambda (y) y) (lambda () (+ x y))))))
      (r:define
      (r:variable 'function)
      (r:lambda
        (list (r:variable 'x) (r:variable 'y))
        (list
        (r:apply
          (r:lambda (list (r:variable 'x)) (list (r:apply (r:variable 'x) (list (r:number 5)))))
          (list
          (r:apply
            (r:lambda (list (r:variable 'y)) (list (r:variable 'y)))
            (list
            (r:lambda
              '()
              (list (r:apply (r:variable '+) (list (r:variable 'x) (r:variable 'y)))))))))))))
    )

)


(define tests
  (test-suite "Tests"
    test-1
    test-2
    test-3
    test-4
    test-5
    test-6
    test-7
    test-8-1
    test-8-2
    test-8-3
    test-8-4
    test-8-5
  )
)

(exit (run-tests tests 'verbose))