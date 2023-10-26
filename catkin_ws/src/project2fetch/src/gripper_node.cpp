#include "ros/ros.h"
#include <actionlib/client/simple_action_client.h>
#include <control_msgs/GripperCommandAction.h>
#include <moveit/move_group_interface/move_group_interface.h>

#include "project2fetch/goalStatus.h"  // Include your custom message

// Global variables to track gripper action completion
bool gripperActionCompleted = false;
int targets = 0;

// Callback function for gripper action completion
void gripperActionCallback(const actionlib::SimpleClientGoalState& state,
                          const control_msgs::GripperCommandResultConstPtr& result)
{
    ROS_INFO("Gripper action completed: %s", state.toString().c_str());
    gripperActionCompleted = true;
}

void goalStatusCallback(const project2fetch::goalStatus::ConstPtr& msg)
{
    if (msg->goal_reached)
    {
        // Perform gripper action (close gripper, for example)
        // ...
        ROS_INFO("Gripper action performed.");
    }
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "gripper_node");
    ros::NodeHandle nh;

    // Create a subscriber for goal status
    ros::Subscriber goal_status_sub = nh.subscribe("goal_status", 10, goalStatusCallback);

    ros::AsyncSpinner spinner(1);
    spinner.start();

    // Create Gripper Action Clients
    actionlib::SimpleActionClient<control_msgs::GripperCommandAction> gripperClient("/gripper_controller/gripper_action", true);
    actionlib::SimpleActionClient<control_msgs::GripperCommandAction> gripperCloseClient("/gripper_controller/gripper_action", true);

    // Wait for the gripper action servers to start
    ROS_INFO("Waiting for gripper action server...");
    gripperClient.waitForServer();

    // for (size_t i = 0; i < targets.size(); ++i)
    // {
    //     // ... (Your arm motion planning code)

    //     // Operate the gripper based on the target location
    //     if (i == 0)  // If it's the first location, close the gripper
    //     {
    //         control_msgs::GripperCommandGoal gripperGoal;
    //         gripperGoal.command.position = 0.05; // Replace with your gripper closed position
    //         gripperGoal.command.max_effort = 100.0; // Adjust max_effort as needed

    //         gripperCloseClient.sendGoal(gripperGoal, &gripperActionCallback);
    //         gripperActionCompleted = false;

    //         while (!gripperActionCompleted)
    //         {
    //             ros::spinOnce(); // Allow ROS to process callbacks
    //             ros::Duration(0.1).sleep(); // Add a small delay
    //         }
    //     }
    //     else if (i == 1)  // If it's the second location, open the gripper
    //     {
    //         control_msgs::GripperCommandGoal gripperGoal;
    //         gripperGoal.command.position = 0.5; // Replace with your gripper open position
    //         gripperGoal.command.max_effort = 100.0; // Adjust max_effort as needed

    //         gripperOpenClient.sendGoal(gripperGoal, &gripperActionCallback);
    //         gripperActionCompleted = false;

    //         while (!gripperActionCompleted)
    //         {
    //             ros::spinOnce(); // Allow ROS to process callbacks
    //             ros::Duration(0.1).sleep(); // Add a small delay
    //         }
    //     }

    //     // ... (Continue with the next arm motion or target)
    // }

    // Shutdown ROS
    ros::shutdown();
    return 0;
}
