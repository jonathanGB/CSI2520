#lang racket
;;; Racket/Scheme/Lisp Assignment


;; Question 1
(define (totalList L)

  (if (empty? L) `0 (+ (car L) (totalList (cdr L))))

)

(define (getWeightedFilter iL nL)

  (let ((total (totalList iL)))

    (if (empty? nL) `() (cons (/ (car nL) total) (getWeightedFilter iL (cdr nL))))

  )

)

(define (filterElement filterList inputList)

  (if (empty? filterList) 0

      (if (empty? inputList) 0
         (+ (* (car filterList) (car inputList)) (filterElement (cdr filterList) (cdr inputList)))))
  )

(define (filterList weightedFilter inputList)
  (if (empty? inputList) `()
      (cons (filterElement weightedFilter inputList) (filterList weightedFilter (cdr inputList))))
)

(define (filter inputFilter inputList)
  (filterList (getWeightedFilter inputFilter inputFilter) inputList)
)



;; Question 2a
(define (sumNumbers inputList)
  (if (empty? inputList) `(() 0)
      (let ((answerList (sumNumbers (cdr inputList))))
        (if (number? (car inputList))
            (cons (car answerList) (list (+ (cadr answerList) (car inputList))))
            (cons (cons (car inputList) (car answerList)) (list (cadr answerList)))
        )
      )
  )
)



;; Question 2b
(define (quaternary num)
  (let ((Power (findPower num 0)))
    (string->number (getQuaternary num Power ""))
  )
)

(define (findPower num Power)
  (if (>= (/ num (expt 4 Power)) 1) (findPower num (+ Power 1))
     (if (> Power 0)
         (- Power 1)
         0
     )
  )
)

(define (getQuaternary num pow output)
  (let ((exponent (expt 4 pow))) 
    (if (>= pow 0)
      (getQuaternary (modulo num exponent) (- pow 1) (string-append output (number->string (quotient num exponent))))
      output
    )
  )
)



;; Question 3
(define (cubeLess X B)
  (- B (expt X 3))
)

(define (smallerCube borne)
  (getAllSmallerCube borne 1 '())
)

(define (getAllSmallerCube B X output)
  (let ((diff (cubeLess X B)))
    (if (>= diff 0) (getAllSmallerCube B (+ X 1) (append output (list (list X diff))))
        output
     )
  )
)

(define (restSum smallerList)
  (getRestSum smallerList 0)
)

(define (getRestSum smallerList sum)
  (if (empty? smallerList)
      sum
      (getRestSum (cdr smallerList) (+ sum (cadr (car smallerList))))
   )
)

(define (showAllRestSum i j)
  (getAllRestSum i j '())
)

(define (getAllRestSum i j output)
  (if (<= i j)
      (let ((result (restSum(smallerCube i))))
        (if ( = (modulo result 3) 0) (getAllRestSum (+ i 1) j (append output (list (list i result) )))
            (getAllRestSum (+ i 1) j output)
        )
      )
      output
  )
)