;; Auto-generated. Do not edit!


(when (boundp 'project2fetch::gripperStatus)
  (if (not (find-package "PROJECT2FETCH"))
    (make-package "PROJECT2FETCH"))
  (shadow 'gripperStatus (find-package "PROJECT2FETCH")))
(unless (find-package "PROJECT2FETCH::GRIPPERSTATUS")
  (make-package "PROJECT2FETCH::GRIPPERSTATUS"))

(in-package "ROS")
;;//! \htmlinclude gripperStatus.msg.html


(defclass project2fetch::gripperStatus
  :super ros::object
  :slots (_gripper_closed ))

(defmethod project2fetch::gripperStatus
  (:init
   (&key
    ((:gripper_closed __gripper_closed) nil)
    )
   (send-super :init)
   (setq _gripper_closed __gripper_closed)
   self)
  (:gripper_closed
   (&optional __gripper_closed)
   (if __gripper_closed (setq _gripper_closed __gripper_closed)) _gripper_closed)
  (:serialization-length
   ()
   (+
    ;; bool _gripper_closed
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _gripper_closed
       (if _gripper_closed (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _gripper_closed
     (setq _gripper_closed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get project2fetch::gripperStatus :md5sum-) "0bb9f49e5ee44b74c38bc58a62045bee")
(setf (get project2fetch::gripperStatus :datatype-) "project2fetch/gripperStatus")
(setf (get project2fetch::gripperStatus :definition-)
      "bool gripper_closed


")



(provide :project2fetch/gripperStatus "0bb9f49e5ee44b74c38bc58a62045bee")


