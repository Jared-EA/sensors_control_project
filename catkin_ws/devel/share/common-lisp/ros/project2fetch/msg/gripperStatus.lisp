; Auto-generated. Do not edit!


(cl:in-package project2fetch-msg)


;//! \htmlinclude gripperStatus.msg.html

(cl:defclass <gripperStatus> (roslisp-msg-protocol:ros-message)
  ((gripper_closed
    :reader gripper_closed
    :initarg :gripper_closed
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass gripperStatus (<gripperStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <gripperStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'gripperStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name project2fetch-msg:<gripperStatus> is deprecated: use project2fetch-msg:gripperStatus instead.")))

(cl:ensure-generic-function 'gripper_closed-val :lambda-list '(m))
(cl:defmethod gripper_closed-val ((m <gripperStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader project2fetch-msg:gripper_closed-val is deprecated.  Use project2fetch-msg:gripper_closed instead.")
  (gripper_closed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <gripperStatus>) ostream)
  "Serializes a message object of type '<gripperStatus>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gripper_closed) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <gripperStatus>) istream)
  "Deserializes a message object of type '<gripperStatus>"
    (cl:setf (cl:slot-value msg 'gripper_closed) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<gripperStatus>)))
  "Returns string type for a message object of type '<gripperStatus>"
  "project2fetch/gripperStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'gripperStatus)))
  "Returns string type for a message object of type 'gripperStatus"
  "project2fetch/gripperStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<gripperStatus>)))
  "Returns md5sum for a message object of type '<gripperStatus>"
  "0bb9f49e5ee44b74c38bc58a62045bee")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'gripperStatus)))
  "Returns md5sum for a message object of type 'gripperStatus"
  "0bb9f49e5ee44b74c38bc58a62045bee")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<gripperStatus>)))
  "Returns full string definition for message of type '<gripperStatus>"
  (cl:format cl:nil "bool gripper_closed~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'gripperStatus)))
  "Returns full string definition for message of type 'gripperStatus"
  (cl:format cl:nil "bool gripper_closed~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <gripperStatus>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <gripperStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'gripperStatus
    (cl:cons ':gripper_closed (gripper_closed msg))
))
