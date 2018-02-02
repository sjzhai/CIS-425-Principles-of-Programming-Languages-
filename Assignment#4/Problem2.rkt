#lang racket

(define (interp exp)
  (cond
    [(number? exp) exp]
    [(list? exp)
     (let ([op (car exp)]
           [exp1 (car (cdr exp))]
           [exp2 (car (cdr (cdr exp)))])
       (let ([number1 (interp exp1)]
             [number2 (interp exp2)])
         (cond
           [(eqv? op '+)(+ number1 number2)]
           [(eqv? op '*)(* number1 number2)]
           [#t(error "Error: Not a valid E term")])))]
    ))

