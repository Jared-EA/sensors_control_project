// move_arm_node.cpp

#include "ros/ros.h"
#include <thread>
#include <ros/ros.h>
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

int main(int argc, char **argv)
{
    // Initialize ROS node
    ros::init(argc, argv, "move_arm_node");
    ros::NodeHandle nh;

    // Start a spin thread
    ros::AsyncSpinner spinner(1);
    spinner.start();

    // Setup move group
    static const std::string PLANNING_GROUP = "robot_arm"; // Change this to your robot's planning group name
    moveit::planning_interface::MoveGroupInterface move_group(PLANNING_GROUP);

    // You can set the reference frame for your robot here
    move_group.setPoseReferenceFrame("base_link");

    // Specify goal pose
    geometry_msgs::Pose target_pose;
    target_pose.orientation.w = 1.0; // This is just an example, adjust the orientation as needed
    target_pose.position.x = 0.5;    // Adjust these values for your goal
    target_pose.position.y = 0.25;
    target_pose.position.z = 0.5;
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

    // Shutdown ROS
    ros::shutdown();
    return 0;
}