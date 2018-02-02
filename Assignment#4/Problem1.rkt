#lang racket

(define (sum-all xs)
    (if (null? xs)
        0
        (if (list? (car xs))
            (+ (sum-all (car xs)) (sum-all (cdr xs)))
            (+ (car xs) (sum-all (cdr xs))))))
