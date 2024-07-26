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
(require rackunit)
(require rackunit/text-ui)
(require "hw4-util.rkt")
(require "hw4.rkt")

(define (stream-first s)
  (match (s)
    [(stream-add x _) x]))

(define (stream-rest s)
  (match (s)
    [(stream-add _ r) r]))

(define (naturals)
  (define (naturals-iter n)
    (thunk
      (stream-add
        n (naturals-iter (+ n 1)))))
  (naturals-iter 0))

(define (set->list p)
  (match (p)
    [(set-empty) (list)]
    [(set-add x h)
      (cons x (set->list h))]))

(define-check (check-set? given expected)
  (check-equal? (set->list given) expected))

(define-test-suite test-1
  (test-case "Exercise 1. stream-skip"
    (define s1 (stream-skip 10 (naturals)))
    (check-equal? (stream-first s1) 10)
    (check-equal? (stream-first (stream-rest s1)) 11)
    (check-equal? (stream-first (stream-rest (stream-rest s1))) 12)
    (define s2 (stream-skip 0 (naturals)))
    (check-equal? (stream-first s2) 0)
    (check-equal? (stream-first (stream-rest s2)) 1)
    (check-equal? (stream-first (stream-rest (stream-rest s2))) 2)
  )
)

(define-test-suite test-2
  (test-case "Exercise 2. stream-fold"
    (define s (stream-fold cons empty (naturals)))
    (check-equal? (stream-first s) empty)
    (check-equal? (stream-first (stream-rest s)) (list 0))
    (check-equal? (stream-first (stream-rest (stream-rest s))) (list 1 0))
    (check-equal? (stream-first (stream-rest (stream-rest (stream-rest s)))) (list 2 1 0))
  )
)

(define-test-suite test-3
  (test-case "Exercise 3. set-void"
    (check-set? set-void (list))
  )
)

(define-test-suite test-4
  (test-case "Exercise 4. set-epsilon"
    (check-set? set-epsilon (list ""))
  )
)

(define-test-suite test-5
  (test-case
    "Exercise 5. set-char"
    (check-set?
      (set-char #\a)
      (list "a"))
    (check-set?
      (set-char #\b)
      (list "b"))
  )
)

(define-test-suite test-6
    (test-case "Exercise 6. set-prefix"
      (define p1
        (thunk
          (set-add "c"
            (thunk
              (set-add "d"
                (thunk
                  (set-add "e" (thunk (set-empty)))))))))
      (define p2
        (thunk
          (set-add ""
            (thunk
              (set-add "bar" (thunk (set-empty)))))))
      (check-set?
        (set-prefix "a" p1)
        (list "ac" "ad" "ae"))
      (check-set?
        (set-prefix "foo" p2)
        (list "foo" "foobar"))
      (check-set?
        (set-prefix "foo" (thunk (set-empty)))
        (list))
    )
)

(define-test-suite test-7
  (test-case "Exercise 7. set-union"
    (define p1
      (thunk
        (set-add "1"
          (thunk
            (set-add "2"
              (thunk
                (set-add "3"
                  (thunk
                    (set-add "4" (thunk (set-empty)))))))))))
    (define p2
      (thunk
        (set-add "a"
          (thunk
            (set-add "b"
              (thunk (set-empty)))))))
    (check-set?
      (set-union p1 p2)
      (list "1" "a" "2" "b" "3" "4"))
    (check-set?
      (set-union p2 p1)
      (list "a" "1" "b" "2" "3" "4"))
    (check-set?
      (set-union (thunk (set-empty)) p1)
      (list "1" "2" "3" "4"))
    (check-set?
      (set-union p1 (thunk (set-empty)))
      (list "1" "2" "3" "4"))
    (check-set?
      (set-union
        (thunk (set-empty))
        (thunk (set-empty))
      )
      (list))
    (struct eager-error exn:fail:user ())
    (define p3
      (thunk
        (set-add "1"
          (thunk (raise (eager-error "p3: Too eager!" (current-continuation-marks)))))))
    (define p4
      (thunk
        (set-add "a"
          (thunk (set-empty)))))
    ; The first 3 elements should be visible, but trying to retrieve
    ; any more elements triggers p4
    (define (call x) (x))
    (match (set-union p3 p4)
      [(app call
          (set-add "1"
            (app call
              (set-add "a" p))))
        (with-handlers (
            [eager-error? (lambda (e) (void))]
          )
          (p)
          ; After the first 2 elements, we must trigger an exception
          (fail "set-union called too many (force)!")
        )
      ]
    )
  )
)

(define-test-suite test-8
  (test-case "Exercise 8. set-concat"
    (define p1
      (thunk
        (set-add "1"
          (thunk
            (set-add "2"
              (thunk
                (set-add "3"
                  (thunk
                    (set-add "4" (thunk (set-empty)))))))))))
    (define p2
      (thunk
        (set-add "a"
          (thunk
            (set-add "b"
              (thunk (set-empty)))))))

    (check-set?
      (set-concat p1 p2)
      (list "1a" "2a" "1b" "3a" "2b" "4a" "3b" "4b")
    )
    (check-set?
      (set-concat p2 p1)
      (list "a1" "b1" "a2" "b2" "a3" "b3" "a4" "b4")
    )
  )
)
(define-test-suite test-9
  (test-case "Exercise 9. r:eval-exp"
    (check-equal?
      (r:eval-exp
        ; (+ 1 2)
        (r:apply
          (r:variable '+)
          (list (r:number 1) (r:number 2))
        )
      )
      (+ 1 2)
    )
    (check-equal?
      (r:eval-exp
        ; (+ 1)
        (r:apply
          (r:variable '+)
          (list (r:number 1))
        )
      )
      1
    )
    (check-equal?
      (r:eval-exp
        ; (+ 1 2 3)
        (r:apply
          (r:variable '+)
          (list (r:number 1) (r:number 2) (r:number 3))
        )
      )
      (+ 1 2 3)
    )
    (check-equal?
      (r:eval-exp
        ; (+ (* 1 2) 3 4)
        (r:apply
          (r:variable '+)
          (list (r:apply (r:variable '*) (list (r:number 1) (r:number 2))) (r:number 3) (r:number 4))
        )
      )
      (+ (* 1 2) 3 4)
    )
  )
)

(define-test-suite test-10
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (test-case "Exercise 10. r:exp-to-string"
    (check-equal?
      (r:exp-to-string
        (r:apply
          (r:variable '+)
          (list)
        )
      )
      "(+)"
    )
    (check-equal?
      (r:exp-to-string
        (r:apply
          (r:variable '+)
          (list (r:number 1))
        )
      )
      "(+ 1)"
    )
    (check-equal?
      (r:exp-to-string
        (r:apply
          (r:variable '+)
          (list (r:number 1) (r:number 2))
        )
      )
      "(+ 1 2)"
    )
    (check-equal?
      (r:exp-to-string
        (r:apply
          (r:variable '+)
          (list (r:apply (r:variable '*) (list (r:number 1) (r:number 2))) (r:number 3) (r:number 4))
        )
      )
      "(+ (* 1 2) 3 4)"
    )
    (check-equal?
      (r:exp-to-string
        (r:apply
          (r:apply
            (r:variable 'f)
            (list (r:number 1) (r:number 2) (r:number 3) (r:number 4))
          )
          (list (r:number 5))
        )
      )
      "((f 1 2 3 4) 5)"
    )

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
    test-8
    test-9
    test-10
  )
)
(exit (run-tests tests 'verbose))