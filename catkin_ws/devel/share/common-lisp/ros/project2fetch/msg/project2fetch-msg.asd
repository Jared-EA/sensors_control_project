
(cl:in-package :asdf)

(defsystem "project2fetch-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "goalStatus" :depends-on ("_package_goalStatus"))
    (:file "_package_goalStatus" :depends-on ("_package"))
    (:file "gripperStatus" :depends-on ("_package_gripperStatus"))
    (:file "_package_gripperStatus" :depends-on ("_package"))
  ))