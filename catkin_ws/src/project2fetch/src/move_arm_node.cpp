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

const double endEffLength = 0.2;
const double startHeightOffset = 0.15;
const double offset = 0.03;

// Create a structure for the target points
struct TargetPoint {
    double x;
    double y;
    double z;
};

std::vector<TargetPoint> receivedTargets;
std::vector<TargetPoint> targets;

void topicCallback(const geometry_msgs::Point::ConstPtr& msg) {
    TargetPoint receivedTarget;
    receivedTarget.x = msg->x;
    receivedTarget.y = msg->y;
    receivedTarget.z = msg->z;
    receivedTargets.push_back(receivedTarget);

    // Print the received point using ROS_INFO
    static int pointCounter = 1; // static to retain its value across function calls
    ROS_INFO("Point %d: x = %f, y = %f, z = %f", pointCounter, receivedTarget.x, receivedTarget.y, receivedTarget.z);
    pointCounter++;
}


int main(int argc, char **argv)
{
    // Initialize ROS node
    ros::init(argc, argv, "move_arm_node");
    ROS_INFO("ROS node initiated");

    // Create a ROS NodeHandle
    ros::NodeHandle nh;
    ROS_INFO("ROS handle created");

    ROS_INFO("Main loop started");

    ros::Subscriber sub = nh.subscribe("position", 2, topicCallback);

    std::vector<TargetPoint> dropOffPoints = {
        {0.0, -0.7, 0.0},
        {0.1, -0.7, 0.0}
        
    };

    // Wait until two messages are received
    ros::Rate rate(10);  // Checking at 10 Hz
    while (ros::ok() && receivedTargets.size() < 2) {
        ros::spinOnce();
        rate.sleep();
    }


    for (auto &target : receivedTargets) {
        targets.push_back(target);
    }
    receivedTargets.clear(); // Clear after copying to avoid redundancy.

    // Check that there are equal numbers of target points and drop-off points
    if (targets.size() != dropOffPoints.size()) {
        ROS_ERROR("The number of target points and drop-off points must be equal.");
        return 1;
    }
    
    // Create an instance of ArmMotion
    ArmMotion arm_motion(nh);

    // Start a spin thread
    ros::AsyncSpinner spinner(1);
    spinner.start();

    arm_motion.moveOrientationPose("Orientation Set Down");

    for (size_t i = 0; i < targets.size(); i++) {
        // Convert Points to geometry_msgs::Pose
        geometry_msgs::Pose initial_pose;
        geometry_msgs::Pose target_pose;
        geometry_msgs::Pose initial_dropoff_pose;
        geometry_msgs::Pose dropoff_pose;

        initial_pose.position.x = targets[i].x-offset;
        initial_pose.position.y = targets[i].y;
        initial_pose.position.z = targets[i].z + startHeightOffset + endEffLength;

        target_pose.position.x = targets[i].x-offset;
        target_pose.position.y = targets[i].y;
        target_pose.position.z = targets[i].z + endEffLength;

        initial_dropoff_pose.position.x = dropOffPoints[i].x;
        initial_dropoff_pose.position.y = dropOffPoints[i].y;
        initial_dropoff_pose.position.z = initial_pose.position.z;

        dropoff_pose.position.x = dropOffPoints[i].x;
        dropoff_pose.position.y = dropOffPoints[i].y;
        dropoff_pose.position.z = target_pose.position.z;
        

        // Move to target

        if (!arm_motion.moveToTarget(initial_pose)) {
            ROS_ERROR("Failed to move to target");
            continue;
        }
        
        if (!arm_motion.moveToTarget(target_pose)) {
            ROS_ERROR("Failed to move to target");
            continue;
        }
        ROS_INFO("Move completed to point 1");

        // Close gripper
        arm_motion.controlGripper("close");

        if (!arm_motion.moveToTarget(initial_pose)) {
            ROS_ERROR("Failed to move to target");
            continue;
        }

        if (!arm_motion.moveToTarget(initial_dropoff_pose)) {
            ROS_ERROR("Failed to move to target");
            continue;
        }

        if (!arm_motion.moveToTarget(dropoff_pose)) {
            ROS_ERROR("Failed to move to target");
            continue;
        }
        ROS_INFO("Move completed to point 2");

        arm_motion.controlGripper("open");

        if (!arm_motion.moveToTarget(initial_dropoff_pose)) {
            ROS_ERROR("Failed to move to target");
            continue;
        }

    }

    // Shutdown ROS
    ros::shutdown();
    return 0;}
    