#lang errortrace typed/racket
#|Abdi Abera
    ===> PLEASE DO NOT DISTRIBUTE SOLUTIONS NOR TESTS PUBLICLY <===

   We ask that solutions be distributed only locally -- on paper, on a
   password-protected webpage, etc.

   Students are required to adhere to the University Policy on Academic
   Standards and Cheating, to the University Statement on Plagiarism and the
   Documentation of Written Work, and to the Code of Student Conduct as
   delineated in the catalog of Undergraduate Programs. The Code is available
   online at: http://www.umb.edu/life_on_campus/policies/code/

|#
(require "hw4-util.rkt")
(provide (all-defined-out))

(: stream-skip
  (All [Elem] ; Parameterized on the type of the elements of the stream
    (->
      ; The first parameter is the number of elements we wish to skip
      Real
      ; The input is a stream of elements
      (stream Elem)
      ; The output is a stream of elements
      (stream Elem)
    )
  )
)
(define (stream-skip n s)
  (cond
  [(<= n 0) s]
  [(match (s)
  [(stream-add ab abe) (stream-skip (- n 1) (thunk (abe)))])]
  [else (stream-skip (- n 1) (stream-rest s))]))


(: stream-fold
  ; We have 2 type parameters,
  ; 1. the type of elements of the stream
  ; 2. the type of the result being accumulated
  (All [Elem Accum]
    (->
      ; The type of the step function f
      (-> Elem Accum Accum)
      ; The type of the value being accumulated
      Accum
      ; The input stream of elements
      (stream Elem)
      ; The output stream of folded elements
      (stream Accum)
    )
  )
)
;;defining stream-fold with its param
(define (stream-fold f a s)
;;this used to delay the computation
  (thunk
  ;;this is to match s
  (match (s)
  ;;this check if s is stream-add with head and tail
  [(stream-add ab abe)
;;recusrive
  (stream-add a (stream-fold f ( f ab a) (thunk(abe))))])))
;;this is annotation for set-void
(: set-void set)
(define set-void
;;thunk will evaluate set-empty
  (thunk (set-empty)))
;;this is annotation for set-epsilon
(: set-epsilon set)
(define set-epsilon
;;thunk will evaluate empty string
  (thunk (set-add "" (thunk (set-empty)))))
;;this is type annotation forset-char
(: set-char (-> Char set))
(define (set-char x)
;;now the thunk will evaluates string of x
  (thunk (set-add (string x) (thunk (set-empty))))
)
;;this is type annotation of set-prefix
(: set-prefix (-> String set set))
(define (set-prefix s p)
;;delay computation
  (thunk
  ;;this is matching set p
  (match (p)
  [(set-empty) (p)]
  ;;set add with ab head and abe tail
  [(set-add ab abe)
  ;;this will return new set
  (set-add (string-append s ab) (set-prefix s abe))]
  ))
)
;;anotation type for set-union
(: set-union (-> set set set ))
;;defining set-union with param p1 and p2
(define (set-union p1 p2)
;;delaying
  (thunk 
  ;;matching set p1
  (match (p1)
  ;;if our p1 is empty it returns p2
  [(set-empty)
  (p2)]
  [(set-add ab p1)
  ;;this will return new set wuth head and recursively call set-union with tail
  (set-add ab (set-union p2 p1))]))
)
;;this is type annotation for set-concat
(: set-concat (-> set set set))
;;defining set-concat with parameters p2 and p1
(define (set-concat p1 p2)
;;delay
  (thunk 
  (match (p1)
  ;;if p1 is empty then it will return empty set
  [(set-empty) (set-empty)]
  ;;add head and tail
  [(set-add c d)
  ;;concatenating
  ((set-union (set-prefix c p2) (set-concat d p2)))
  ]))
)

(: r:eval-exp (-> r:expression Number))
(define (r:eval-exp exp)
  (match exp
    ; If it's a number, return that number
    [(r:number v) v]
    ; If it's a function with 2 arguments
    [(r:apply (r:variable ab) args)
    ;;this evaluates buit-in
      (define func (r:eval-builtin ab))
      (apply func (map r:eval-exp args))
    ]
  )
)

(: r:exp-to-string (-> r:expression String))
;;this used to mach the exp
(define (r:exp-to-string exp)
  (match exp
  ;;then check  number, if its number convert to string
  [(r:number v) (number->string v)]
  ;;then check  variable, if its variable convert to string
  [(r:variable v) (symbol->string v)]
  ;;this used to convert the argument and function to string
  [(r:apply a b) (string-append "(" (r:exp-to-string a)
  (if (empty? b) "" (string-append " " (string-join (map r:exp-to-string b) " ")))
  ")")]))

