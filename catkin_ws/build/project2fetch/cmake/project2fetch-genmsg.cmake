# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "project2fetch: 2 messages, 0 services")

set(MSG_I_FLAGS "-Iproject2fetch:/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg;-Isensor_msgs:/opt/ros/melodic/share/sensor_msgs/cmake/../msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/melodic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(project2fetch_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg" NAME_WE)
add_custom_target(_project2fetch_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "project2fetch" "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg" ""
)

get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg" NAME_WE)
add_custom_target(_project2fetch_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "project2fetch" "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/project2fetch
)
_generate_msg_cpp(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/project2fetch
)

### Generating Services

### Generating Module File
_generate_module_cpp(project2fetch
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/project2fetch
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(project2fetch_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(project2fetch_generate_messages project2fetch_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_cpp _project2fetch_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_cpp _project2fetch_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(project2fetch_gencpp)
add_dependencies(project2fetch_gencpp project2fetch_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS project2fetch_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/project2fetch
)
_generate_msg_eus(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/project2fetch
)

### Generating Services

### Generating Module File
_generate_module_eus(project2fetch
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/project2fetch
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(project2fetch_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(project2fetch_generate_messages project2fetch_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_eus _project2fetch_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_eus _project2fetch_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(project2fetch_geneus)
add_dependencies(project2fetch_geneus project2fetch_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS project2fetch_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/project2fetch
)
_generate_msg_lisp(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/project2fetch
)

### Generating Services

### Generating Module File
_generate_module_lisp(project2fetch
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/project2fetch
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(project2fetch_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(project2fetch_generate_messages project2fetch_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_lisp _project2fetch_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_lisp _project2fetch_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(project2fetch_genlisp)
add_dependencies(project2fetch_genlisp project2fetch_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS project2fetch_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/project2fetch
)
_generate_msg_nodejs(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/project2fetch
)

### Generating Services

### Generating Module File
_generate_module_nodejs(project2fetch
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/project2fetch
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(project2fetch_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(project2fetch_generate_messages project2fetch_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_nodejs _project2fetch_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_nodejs _project2fetch_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(project2fetch_gennodejs)
add_dependencies(project2fetch_gennodejs project2fetch_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS project2fetch_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/project2fetch
)
_generate_msg_py(project2fetch
  "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/project2fetch
)

### Generating Services

### Generating Module File
_generate_module_py(project2fetch
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/project2fetch
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(project2fetch_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(project2fetch_generate_messages project2fetch_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/gripperStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_py _project2fetch_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/jared/sensors_control_project/catkin_ws/src/project2fetch/msg/goalStatus.msg" NAME_WE)
add_dependencies(project2fetch_generate_messages_py _project2fetch_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(project2fetch_genpy)
add_dependencies(project2fetch_genpy project2fetch_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS project2fetch_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/project2fetch)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/project2fetch
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(project2fetch_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(project2fetch_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/project2fetch)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/project2fetch
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(project2fetch_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(project2fetch_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/project2fetch)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/project2fetch
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(project2fetch_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(project2fetch_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/project2fetch)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/project2fetch
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(project2fetch_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(project2fetch_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/project2fetch)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/project2fetch\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/project2fetch
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(project2fetch_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(project2fetch_generate_messages_py std_msgs_generate_messages_py)
endif()
