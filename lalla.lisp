;;;; lalla.lisp

(in-package #:lalla)
(declaim (optimize speed))

(defparameter* (fail-amount (signed-byte 16)) 8000)


(defun* (negamax -> (signed-byte 16)) 
    ((side (unsigned-byte 1)) (alpha (signed-byte 16)) 
     (beta (signed-byte 16)) (depth-left (unsigned-byte 8)))
  (*let ((score (signed-byte 16) 
		(if (> dept-left 1)
		    (- fail-amount)
		    (static-eval)))
	 (moves (vector (unsigned-byte 16)) 
		(generate-moves side))
	 (saved-piece (unsigned-byte 4) 0)
	 (temp-score (signed-byte 16) 0))
	(loop for current-move in moves do
	     (when (king-capture current-move)
	       (setf score fail-amount))
	     (when (or (<= depth-left 1) 
		       (>= score beta))
	       (return))
	     (setf saved-piece (make-move current-move))
	     (setf temp-score (- (negamax (- 1 turn)
					  (- beta)
					  (if (> alpha score)
					      (- alpha)
					      (- score))
					  (- depth-left 1))))
	     (unmake-move current-move saved-piece)
	     (when (> temp-score score)
               (when (>= temp-score beta) (return))
	       (setf score temp-score)))
	           
	score))
