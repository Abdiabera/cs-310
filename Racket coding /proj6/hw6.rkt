#|
Abdi Abera
    ===> PLEASE DO NOT DISTRIBUTE THE SOLUTIONS PUBLICLY <===

   We ask that solutions be distributed only locally -- on paper, on a
   password-protected webpage, etc.

   Students are required to adhere to the University Policy on Academic
   Standards and Cheating, to the University Statement on Plagiarism and the
   Documentation of Written Work, and to the Code of Student Conduct as
   delineated in the catalog of Undergraduate Programs. The Code is available
   online at: http://www.umb.edu/life_on_campus/policies/code/

|#
;; PLEASE DO NOT CHANGE THE FOLLOWING LINES
#lang typed/racket
(require "hw6-util.rkt")
(provide (all-defined-out))
;; END OF REQUIRES

;; Exercise 1
(: eval-exp (-> memory handle d:expression (eff memory d:value)))
(define (eval-exp mem env exp)
  ; mem is M
  ; env is E
  (match exp
    [(? d:value?)
      ; Return: v ▶ M
     (eff mem exp)
      ]
    [(? d:variable?) ; exp is x
      ; Return: E(x) ▶ M
      (eff mem (environ-get mem env exp))
    ]
    [(d:lambda x t)
     
      ; Return: {E, λx.t} ▶ M
    (eff mem (d:closure env x t))
    ]
    [(d:apply ef ea)
      (match (eval-exp mem env ef)
        ;; ef ⇓E {Ef, λx.tb} ▶ M1
        [(eff M1 (d:closure Ef x tb))
          ;; ea ⇓E va ▶ M2
          (match (eval-exp M1 env ea)
          [(eff M2 va)
          ;; ...
          ;; Eb ← Ef + [x := va] ▶ M3
          (match (environ-push M2 Ef x va)
          [(eff M3 Eb)

          ; ...
          ;; tb ⇓Eb vb ▶ M4
          (match (eval-term M3 Eb tb)
          [(eff M4 vb)
          ;; ..
          ;; Return: vb ▶ M4
          (eff M4 vb)

        ])
          ])
    ])
        ]
      )
    ]
  )
)

;; Exercise 2
(: eval-term (-> memory handle d:term (eff memory d:value)))
(define (eval-term mem env term)
  (match term
    [(d:define x e)
      ;; e ⇓E v ▶ M1
      ;; ...
      ;; E ← [x := v] ▶ M2
      ;; ...
      (match (eval-exp mem env e)
      [(eff mem1 v)
      (define mem2(environ-put mem1 env x v))
      ;; return: void ▶ M2
      (eff mem2 (d:void))])]
    [(d:seq t1 t2)
      ;; ​t1​ ⇓E ​v1 ▶ M1
      ;; ...
      ;; t2 ⇓E v2 ▶ M2
      ;; ...
      ;; return: v2 ▶ M2

      (match (eval-term mem env t1)
      [(eff mem1 v1)
      (eval-term mem1 env t2)])]
    [(? d:expression?) (eval-exp mem env term)]
  )
)

;; Exercise 3 (Manually graded)
#|

During class, we learned the lambda D Racket has the ability to bind functions and variable
closures by allowing us to define the higher order quality in its programming environment.
According to my understanding, due to its immutable environment and ease of handling heap
memory, Lambda D differs from Racket. In addition of constraints and environments, Lambda 
D is very useful since it helps us debug code by providing additional information about 
the state of variables, functions, and environments. Also lambda variables that bind, will create a new environment.


Let us take an example.
(d:define x 10).
(d:define f(lambda (y)(+ x y)))
(d:define x 20)
(f 3)
In Racket, the output will be 23, because, closure created by (lambda (y) + x y),

In lambda D, the output will be 13, as we see x is 10. x is taken by closure one time, which is 10.
then when we call 'f' with 3, we get 13.


                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                        citation


      I did this homework from what I learned from my professor and from canva website
      https://umassboston.instructure.com/courses/229/files/65477?module_item_id=19657
      https://umassboston.instructure.com/courses/229/files/52905?module_item_id=17516
      https://umassboston.instructure.com/courses/229/files/70328?module_item_id=21081


|#
