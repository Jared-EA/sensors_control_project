#ifndef ARM_MOTION_H
#define ARM_MOTION_H


#include <ros/ros.h>
#include <geometry_msgs/Pose.h>
#include <control_msgs/GripperCommandAction.h>
#include <moveit/move_group_interface/move_group_interface.h>
#include "project2fetch/goalStatus.h" // custom message



class ArmMotion {
public:
    ArmMotion(ros::NodeHandle& node_handle);
    bool moveToTarget(const geometry_msgs::Pose& target_pose);
    bool controlGripper(const std::string& position);
    bool moveOrientationPose(const std::string& orientation);
    // Add other arm-related methods and members as needed

    private:
        moveit::planning_interface::MoveGroupInterface move_group;
        moveit::planning_interface::MoveGroupInterface gripper_group;
        moveit::planning_interface::MoveGroupInterface torso_move_group;
        // actionlib::SimpleActionClient<control_msgs::GripperCommandAction> gripper_group;
        ros::Publisher goal_status_pub;
        ros::Publisher gripper_publisher;
        ros::NodeHandle nh;
};

#endif // ARM_MOTION_H