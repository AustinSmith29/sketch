;;; invaders.lisp

(defpackage :invaders (:use :cl :sketch))
(in-package :invaders)

(defstruct player x y lives)

(defun draw-player (player)
  (with-pen (make-pen :fill +green+)
    (rect (player-x player) (player-y player) 32 32)))

(defsketch invaders
    (
     (title "Space Invaders")
     (width 400)
     (height 400)
     (player (make-player :x 200 :y 350 :lives 3))
     )

  (background +black+)
  (draw-player player)
 )

(defmethod kit.sdl2:keyboard-event :after ((window invaders) state ts repeat-p keysym)
  (when (and (eql state :keydown)
	     (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-right))
    (with-slots (player) window
      (setf player (make-player :x (+ (player-x player) 5) :y (player-y player)
				:lives (player-lives player)))))
  
  (when (and (eql state :keydown)
	     (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-left))
    (with-slots (player) window
      (setf player (make-player :x (- (player-x player) 5) :y (player-y player)
				:lives (player-lives player))))))
 
