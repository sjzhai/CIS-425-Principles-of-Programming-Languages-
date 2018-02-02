#lang racket

(define (TR E)
  (cond
    [(number? E) E]
    [(list? E)
     (let ([op (car E)]
           [e1 (car (cdr E))]
           [e2 (car (cdr (cdr E)))])
       (let ([n1 (TR e1)] 
             [n2 (TR e2)])
         (cond
           [(eqv? op '+) (quasiquote (* (unquote n1) (unquote n2)))]
           [(eqv? op '*) (quasiquote (+ (unquote n1) (unquote n2)))]
           )))
     ]))
