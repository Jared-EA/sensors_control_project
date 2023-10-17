// move_arm_node.cpp

#include "ros/ros.h"
#include <thread>

#include <sensor_msgs/Image.h>
#include <sensor_msgs/LaserScan.h>

#include <message_filters/subscriber.h>
#include <message_filters/synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include <moveit/move_group_interface/move_group_interface.h>
#include <moveit/planning_scene_interface/planning_scene_interface.h>

#include <moveit_msgs/DisplayRobotState.h>
#include <moveit_msgs/DisplayTrajectory.h>
#include <moveit_msgs/AttachedCollisionObject.h>
#include <moveit_msgs/CollisionObject.h>
#include <moveit_visual_tools/moveit_visual_tools.h>

#include "gripper.cpp"


// Create a structure for the target points
struct TargetPoint {
    double x;
    double y;
    double z;
};

int main(int argc, char **argv)
{
    // List of target points
    std::vector<TargetPoint> targets = {
        {0.5, 0.25, 0.5},
        {0.6, 0.0,  0.4},
        // Add more points as needed
    };

    GripperController gripper;  // Create gripper controller

    // Initialize ROS node
    ros::init(argc, argv, "move_arm_node");
    ros::NodeHandle nh;

    // Start a spin thread
    ros::AsyncSpinner spinner(1);
    spinner.start();

    // Setup move group
    static const std::string PLANNING_GROUP = "robot_arm"; // Change this to your robot's planning group name
    moveit::planning_interface::MoveGroupInterface move_group(PLANNING_GROUP);

    // Create a MoveGroupInterface for the gripper
    moveit::planning_interface::MoveGroupInterface gripper_group("gripper");


    // You can set the reference frame for your robot here
    move_group.setPoseReferenceFrame("base_link");

    for (size_t i = 0; i < targets.size(); ++i)
    {
        const TargetPoint &target = targets[i];
        // Specify goal pose
        geometry_msgs::Pose target_pose;
        target_pose.orientation.w = 1.0; // This is just an example, adjust the orientation as needed
        target_pose.position.x = target.x;
        target_pose.position.y = target.y;
        target_pose.position.z = target.z;

        move_group.setPoseTarget(target_pose);

        // Plan motion to goal
        moveit::planning_interface::MoveGroupInterface::Plan my_plan;
        bool success = (move_group.plan(my_plan) == moveit::planning_interface::MoveItErrorCode::SUCCESS);
        ROS_INFO_NAMED("tutorial", "Visualizing plan (pose goal) %s", success ? "" : "FAILED");

        // If planning is successful, execute
        if (success)
        {
            move_group.execute(my_plan);
        }

        // Operate the gripper based on the target location
        if (i == 0)  // If it's the first location, close the gripper
        {
            gripper_group.setJointValueTarget("gripper", 0);  // Replace /*closed_value*/ with the actual joint value representing closed gripper
            gripper_group.move();
        }
        else if (i == 1)  // If it's the second location, open the gripper
        {
            gripper_group.setJointValueTarget("gripper", 0.5);  // Replace /*open_value*/ with the actual joint value representing open gripper
            gripper_group.move();
        }

        // Optionally, add a delay between moves
        ros::Duration(1.0).sleep(); 
    }

    // Shutdown ROS
    ros::shutdown();
    return 0;}