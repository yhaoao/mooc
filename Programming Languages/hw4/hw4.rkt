
#lang racket

;; put your code below
(define (sequence x y z) (if (< y x) '() (cons x (sequence (+ x z) y z))))


(define (string-append-map xs suffix)
  (map (lambda (str) (string-append str suffix)) xs))

(define (list-nth-mod xs n) 
  (if (< n 0) 
      (error "list-nth-mod: negative number")
      (if (= 0 (length xs))
          (error "list-nth-mod: empty list")
          (car (list-tail xs (remainder n (length xs)))))))

(define (stream-for-n-steps s n)
  (if (= n 0) '() (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (= 0 (remainder x 5)) (- 0 x) x) (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))


(define dan-then-dog
  (letrec ([f (lambda (x) (cons x (lambda () (f (if (equal? "dan.jpg" x) "dog.jpg" "dan.jpg")))))])
    (lambda () (f "dan.jpg"))))

(define (stream-add-zero s) 
    (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

(define (cycle-lists xs ys) 
  (letrec ([f (lambda (n) (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (lambda () (f (+ n 1)))))]) 
    (lambda () (f 0))))

(define (vector-assoc v vector)
  (letrec ([len (vector-length vector)]
           [f (lambda (n) (if (= n len) #f 
                              (letrec ([nth-v (vector-ref vector n)])
                                (if (pair? nth-v) 
                                    (if (equal? (car nth-v) v) nth-v (f (+ 1 n))) 
                                    (f (+ 1 n))))))])
    (if (= 0 len) #f (f 0))))
  
(define (cached-assoc xs n)
  (letrec ([memo (make-vector n)]
           [slot 0])
    (lambda (v)
      (letrec ([cache-v (vector-assoc v memo)])
        (if cache-v 
            cache-v 
            (let ([res (assoc v xs)])
              (begin 
                (vector-set! memo slot res)
                (set! slot (remainder (+ slot 1) n))
                res)))))))









