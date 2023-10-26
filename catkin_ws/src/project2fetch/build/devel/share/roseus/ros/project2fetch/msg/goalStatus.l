;; Auto-generated. Do not edit!


(when (boundp 'project2fetch::goalStatus)
  (if (not (find-package "PROJECT2FETCH"))
    (make-package "PROJECT2FETCH"))
  (shadow 'goalStatus (find-package "PROJECT2FETCH")))
(unless (find-package "PROJECT2FETCH::GOALSTATUS")
  (make-package "PROJECT2FETCH::GOALSTATUS"))

(in-package "ROS")
;;//! \htmlinclude goalStatus.msg.html


(defclass project2fetch::goalStatus
  :super ros::object
  :slots (_goal_reached ))

(defmethod project2fetch::goalStatus
  (:init
   (&key
    ((:goal_reached __goal_reached) nil)
    )
   (send-super :init)
   (setq _goal_reached __goal_reached)
   self)
  (:goal_reached
   (&optional __goal_reached)
   (if __goal_reached (setq _goal_reached __goal_reached)) _goal_reached)
  (:serialization-length
   ()
   (+
    ;; bool _goal_reached
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _goal_reached
       (if _goal_reached (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _goal_reached
     (setq _goal_reached (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get project2fetch::goalStatus :md5sum-) "a65bc774d2139031955fd7cc94fdd40f")
(setf (get project2fetch::goalStatus :datatype-) "project2fetch/goalStatus")
(setf (get project2fetch::goalStatus :definition-)
      "bool goal_reached


")



(provide :project2fetch/goalStatus "a65bc774d2139031955fd7cc94fdd40f")


