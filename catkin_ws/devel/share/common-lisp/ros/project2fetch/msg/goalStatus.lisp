; Auto-generated. Do not edit!


(cl:in-package project2fetch-msg)


;//! \htmlinclude goalStatus.msg.html

(cl:defclass <goalStatus> (roslisp-msg-protocol:ros-message)
  ((goal_reached
    :reader goal_reached
    :initarg :goal_reached
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass goalStatus (<goalStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <goalStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'goalStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name project2fetch-msg:<goalStatus> is deprecated: use project2fetch-msg:goalStatus instead.")))

(cl:ensure-generic-function 'goal_reached-val :lambda-list '(m))
(cl:defmethod goal_reached-val ((m <goalStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader project2fetch-msg:goal_reached-val is deprecated.  Use project2fetch-msg:goal_reached instead.")
  (goal_reached m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <goalStatus>) ostream)
  "Serializes a message object of type '<goalStatus>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'goal_reached) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <goalStatus>) istream)
  "Deserializes a message object of type '<goalStatus>"
    (cl:setf (cl:slot-value msg 'goal_reached) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<goalStatus>)))
  "Returns string type for a message object of type '<goalStatus>"
  "project2fetch/goalStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'goalStatus)))
  "Returns string type for a message object of type 'goalStatus"
  "project2fetch/goalStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<goalStatus>)))
  "Returns md5sum for a message object of type '<goalStatus>"
  "a65bc774d2139031955fd7cc94fdd40f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'goalStatus)))
  "Returns md5sum for a message object of type 'goalStatus"
  "a65bc774d2139031955fd7cc94fdd40f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<goalStatus>)))
  "Returns full string definition for message of type '<goalStatus>"
  (cl:format cl:nil "bool goal_reached~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'goalStatus)))
  "Returns full string definition for message of type 'goalStatus"
  (cl:format cl:nil "bool goal_reached~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <goalStatus>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <goalStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'goalStatus
    (cl:cons ':goal_reached (goal_reached msg))
))
