#lang racket

;curry function
(define (curry f)
  (lambda (x)
    (lambda (y)
      (f x y))))
(define (sum x y) (+ x y))
(define currysum (curry sum))

;uncurry function
(define (uncurry f)
  (lambda (x y)
    ((f x) y)))
(define (plus x) (lambda (y) (+ x y)))
(define uncurryplus (uncurry plus))