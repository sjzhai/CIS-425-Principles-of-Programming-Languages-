#lang racket

(define (square x) (* x x))
(define L '((1 2) ((3 4) 5)))

(define (treemap fun li)
  (cond
    [(eqv? (list? li) #f) (fun li)]
    [(pair? li) (cons (treemap fun (car li)) (treemap fun (cdr li)))]
    [(eqv? (pair? li) #f) (map fun li)]))