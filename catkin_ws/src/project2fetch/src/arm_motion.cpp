// arm_motion.cpp

#include "arm_motion.h"

#include <ros/ros.h>
#include <geometry_msgs/Pose.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <control_msgs/GripperCommandAction.h>
#include <actionlib/client/simple_action_client.h>

#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>
#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>
#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>

#include "project2fetch/goalStatus.h" // custom message


ArmMotion::ArmMotion(ros::NodeHandle& node_handle) : move_group("robot_arm"), gripper_group("gripper"), torso_move_group("arm_w/torso"), nh(node_handle) { // arm_w/torso, , gripper_group("gripper", true)

    // Initialize MoveIt and other arm-related setup
    ROS_INFO("arm planning group selected");
    ROS_INFO("gripper planning group selected");

    // You can set the reference frame for your robot here
    move_group.setPoseReferenceFrame("base_link");

    gripper_publisher = nh.advertise<control_msgs::GripperCommandActionGoal>("/gripper_controller/gripper_action/goal", 1);
       
}



bool ArmMotion::moveToTarget(const geometry_msgs::Pose& target) {
    // determine desired orientation
    geometry_msgs::PoseStamped current_pose;
    current_pose = torso_move_group.getCurrentPose("wrist_roll_link");  
    
    // Specify goal pose
    geometry_msgs::Pose target_pose;
    target_pose.orientation = current_pose.pose.orientation; 
    target_pose.position.x = target.position.x;
    target_pose.position.y = target.position.y;
    target_pose.position.z = target.position.z;

    torso_move_group.setPoseTarget(target_pose);

    // Plan motion to goal
    moveit::planning_interface::MoveGroupInterface::Plan my_plan;
    bool success = (torso_move_group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
    ROS_INFO("Planning result: %s", success ? "SUCCESS" : "FAILED");

    if (success)
        {
            torso_move_group.execute(my_plan);
            torso_move_group.getCurrentPose();
            ROS_INFO("Completed Movement");
        }
        else {
            ROS_INFO("ERROR: cant reach object");
            
        }

        // add delay between moves
        ros::Duration(1.0).sleep(); 
        
        return success;

}

    

bool ArmMotion::controlGripper(const std::string& position)
  {
    ROS_INFO("Gripper Command Started");

    control_msgs::GripperCommandActionGoal goal;

    if (position == "open") {
        // Define the gripper position to open
        goal.goal.command.position = 0.5;
        ROS_INFO("Gripper opened");
    }
    else if (position == "close") {
        // Define the gripper position to close
        goal.goal.command.position = 0.0;
        ROS_INFO("Gripper closed");
    }

    goal.goal.command.max_effort = 200.0; // Adjust the effort as needed

    // Publish the goal to the gripper action server
    gripper_publisher.publish(goal);
    ROS_INFO("Gripper published");

    ros::Duration(1.5).sleep(); 






    // moveit::planning_interface::MoveGroupInterface::Plan gripper_plan;
    // gripper_group.setJointValueTarget(gripper_group.getNamedTargetValues(position));
    // bool success = (gripper_group.plan(gripper_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
    // // ROS_INFO("Sending gripper open command with joint values: ", gripper_group.getJointValueTarget());

    // if (success) {
    //     gripper_group.execute(gripper_plan);
    //     ROS_INFO("Gripper Task Completed Successfully");
    // } else {
    //     ROS_WARN("Failed to plan and execute gripper motion"); 
    // }

    // return success; 

  }

  bool ArmMotion::moveOrientationPose(const std::string& orientation){
    ROS_INFO("Moving to desired orientation");
    

    moveit::planning_interface::MoveGroupInterface::Plan my_plan_arm;
    
    // 1. Move to home position
    torso_move_group.setJointValueTarget(torso_move_group.getNamedTargetValues(orientation));
    bool success = (torso_move_group.plan(my_plan_arm) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
    torso_move_group.move();
  }