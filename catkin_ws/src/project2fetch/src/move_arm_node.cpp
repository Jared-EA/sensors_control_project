// move_arm_node.cpp

#include "ros/ros.h"
#include <thread>
#include "arm_motion.h"


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

//custom msgs
// #include "project2fetch/goalStatus.h"
// #include <project2fetch/goalStatus.msg>

// #include "gripper.cpp"


// Create a structure for the target points
struct TargetPoint {
    double x;
    double y;
    double z;
};

int main(int argc, char **argv)
{
    // Initialize ROS node
    ros::init(argc, argv, "move_arm_node");
    ROS_INFO("ROS node initiated");

    // Create a ROS NodeHandle
    ros::NodeHandle nh;
    ROS_INFO("ROS handle created");

    ROS_INFO("Main loop started");

    // List of target points
    std::vector<TargetPoint> targets = {
        {0.5, 0.25, 0.5},
        {0.6, 0.0,  0.4},
        // Add more points as needed
    };
    // Make sure there is a drop-off point for each target point
    std::vector<TargetPoint> dropOffPoints = {
        {1.0, 0.0, 0.5},
        {1.1, 0.1, 0.4}
        
    };

    // Check that there are equal numbers of target points and drop-off points
    if (targets.size() != dropOffPoints.size()) {
        ROS_ERROR("The number of target points and drop-off points must be equal.");
        return 1;
    }
    

    // GripperController gripper;  // Create gripper controller

    

    // Create a publisher for goal status
    // ros::Publisher goal_status_pub = nh.advertise<project2fetch::goalStatus>("goal_status", 10);
    // Create a publisher for target points
    // ros::Publisher target_points_pub = nh.advertise<geometry_msgs::Point>("target_points", 10);
    // Create a publisher for gripper position
    // ros::Publisher gripper_publisher = nh.advertise<control_msgs::GripperCommandActionGoal>("/gripper_controller/gripper_action/goal",1);
    
    // Create an instance of ArmMotion
    ArmMotion arm_motion;

    // Start a spin thread
    ros::AsyncSpinner spinner(1);
    spinner.start();

    for (size_t i = 0; i < targets.size(); i++) {
        // Convert TargetPoint to geometry_msgs::Pose
        geometry_msgs::Pose target_pose;
        target_pose.position.x = targets[i].x;
        target_pose.position.y = targets[i].y;
        target_pose.position.z = targets[i].z;
        target_pose.orientation.w = 1.0; // You might need to set orientation properly

        // Move to target
        arm_motion.moveToTarget(target_pose);
        ROS_INFO("Move completed to point 1");
        // if (!arm_motion.moveToTarget(target_pose)) {
        //     ROS_ERROR("Failed to move to target");
        //     continue;
        // }

        // Close gripper
        arm_motion.controlGripper("close");
        ROS_INFO("Gripper Closed");

        // if (!arm_motion.controlGripper("close")) {
        //     ROS_ERROR("Failed to close gripper");
        //     continue;
        // }

        // Convert drop-off point to geometry_msgs::Pose
        geometry_msgs::Pose dropoff_pose;
        dropoff_pose.position.x = dropOffPoints[i].x;
        dropoff_pose.position.y = dropOffPoints[i].y;
        dropoff_pose.position.z = dropOffPoints[i].z;
        dropoff_pose.orientation.w = 1.0; // Set orientation as needed

        arm_motion.moveToTarget(dropoff_pose);
        ROS_INFO("Move completed to point 2");

        arm_motion.controlGripper("open");
        ROS_INFO("Gripper Open");

        // Move to drop-off point
        // if (!arm_motion.moveToTarget(dropoff_pose)) {
        //     ROS_ERROR("Failed to move to drop-off point");
        //     continue;
        // }

        // Open gripper
        // if (!arm_motion.controlGripper("open")) {
        //     ROS_ERROR("Failed to open gripper");
        //     continue;
        // }
    }

    // Shutdown ROS
    ros::shutdown();
    return 0;}
    