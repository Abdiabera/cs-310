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
(provide (all-defined-out))
(require "hw5-util.rkt")
;; END OF REQUIRES

;; Exercise 1
(: s:subst (-> s:expression s:variable s:value s:expression))
(define (s:subst exp var val)
;;base case ;  then if it is number then return it unchanged 
  (match exp
  [(s:number _) exp]
  ;; this checkig if its variable, then we have to substitute if it matches variable 
  [(s:variable name) (if (eq? name (s:variable-name var)) val exp)]
  ;;this is to recursively substitute in its body if expression is lambda
  [(s:lambda param body) (if (eq? (s:variable-name param) 
  (s:variable-name var)) exp (s:lambda param (s:subst body var val)))]
  ;;this is to subsitiute recursively in its body, if our expression is apply
  [(s:apply func arg) (s:apply (s:subst func var val) (s:subst arg var val))]))

;; Exercise 2
(: s:eval (-> (-> s:expression s:variable s:value s:expression) s:expression s:value))
(define (s:eval subst exp)
;;this place evaluates the funstion, if expresion is apply
  (match exp
    [(s:apply ef ea)
      (define vf (s:eval subst ef))
      (match vf
      ;;now, if our function is lambda,subsitute it to its body and then evaluate
        [(s:lambda x eb)
          (s:eval subst (s:subst eb x (s:eval subst ea)))]
          ;; if not lambda
          [else 
          (error "This Is Unkown Expression")])]
    ;; now check if our expression is a value, then return
    [(? s:value?)
      exp
    ]))

;; Exercise 3
(: e:eval (-> e:environ e:expression e:value))
(define (e:eval env exp)
  (match exp 
  ;; this place return expression if its number
  [(e:number ab ) (e:number ab)]
  ;;this will retrieve value from env if expression is a variable
  [(e:variable a) (e:env-get env (e:variable a))]
  ;;this is to evaluate functions and argumnts then apply function to argument, 
  [(e:apply ef ea)
  (define cs (e:eval env ef))
  (define abe (e:eval env ea ))
  (match cs
  ;; this place is, if function is closure then apply in the env (environment)
  [(e:closure fenv param body_of_fun)
  (e:eval (e:env-put fenv param abe) body_of_fun)]
  ;;now if function is not closure then print the following
  [else (error "This Is Unkown Expression")]
  )]
  ;; this will create closure if expresion is lambda
  [(e:lambda param body_of_fun) (e:closure env param body_of_fun)]
  ;; if not match, then 
  [else (error "This Is Unkown Expression")]))

;; Exercise 4 (Manually graded)
#|

4. Manually graded. Describe one situation where implementing λS is a better alternative than λE .
Conversely, describe one situation where λE is a better alternative than λS 

ANS:


As we learned in class, there are two ways that we can evaluate our programming.
its λS and λE. We use λS when there are infinite data structures. Then, we can calculate the values when they are needed.
especially this will help us when we do generators or streams, which generate a number of elements.
it is easy to enhance performance and computations.

Also, there is a time λE is better than λS, as we learned in class while we were running code, it monitors variables and their values 
during execution.For example, we can take the example of eager evaluation.
We can decide λS or λE depending on our programming code, this may include finding the right balance between the level of complexity 
for evaluation and execution factors.

|#

;; Exercise 5 (Manually graded)
#|
5. Manually graded. Describe two benefits of using a formal specification to help with the implementation
of a software system.

It is critical that each member of the collective is equally knowledgeable of the system requirements
in order to prevent inaccuracies during implementation by providing a detailed description of the features.
Furthermore, formal specifications can be used to verify and validate the system's functionality, 
such as verifying the correctness and reliability of the system, allowing potential 
problems to be identified during development. Furthermore, these specifications can even be used to 
generate test cases in order to verify and validate the functionality of the system as a result of reducing 
the cost and effort involved in fixing any problems that may arise.

|#






;; I did this homework from what I learned from my professor and from this link under canva cs450
;;https://umassboston.instructure.com/courses/229/files/38511?module_item_id=15023
;;https://umassboston.instructure.com/courses/229/files/43580?module_item_id=15946