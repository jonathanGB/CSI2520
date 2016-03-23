#lang racket

; Question 1
(define (mergeALot inputList)
  (let ((errorList (detectError inputList `() 1)))
    (if (empty? errorList)
        (mergeList inputList `())
        (begin (write "ERREUR: Les listes suivantes ne sont pas triées: ") (write errorList))
    )
  )
)

(define (mergeList inputList output)
 (if (empty? inputList)
     output
     (if (empty? (car inputList))
         (mergeList (cdr inputList) output) 
         (let ((smallest (getSmallest (caar inputList) (cdr inputList) 0 0))) 
           (mergeList (updateList smallest inputList 0 `()) (append output (list (car smallest))))
         )
     )
 )
)

(define (updateList elem List index outputList)
  (if (empty? List)
      outputList
      (if (= (cadr elem) index)
          (updateList elem (cdr List) (+ index 1) (append outputList (list (cdar List))))
          (updateList elem (cdr List) (+ index 1) (append outputList (list (car List))))
      )
  )
)

(define (getSmallest smallest inputList smallestIndex currIndex)
 (if (empty? inputList)
     (list smallest smallestIndex)
     (if (not (empty? (car inputList)))
         (if (<= smallest (caar inputList))
             (getSmallest smallest (cdr inputList) smallestIndex (+ currIndex 1))
             (getSmallest (caar inputList) (cdr inputList) (+ currIndex 1) (+ currIndex 1))
         )
         (getSmallest smallest (cdr inputList) smallestIndex (+ currIndex 1))
     )
 )
)

(define (detectError inputList errorList index)
  (if (empty? inputList)
      errorList
      (detectError (cdr inputList) (validList (caar inputList) (cdar inputList) errorList index) (+ index 1))
  )
)
      
(define (validList first List errorList index)
  (if (empty? List)
      (append errorList `())
      (if (<= first (car List))
          (validList (car List) (cdr List) errorList index)
          (append errorList (list index))
      )
  )
)



; Question 2

