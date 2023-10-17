#include <actionlib/client/simple_action_client.h>
#include <control_msgs/FollowJointTrajectoryAction.h>

class GripperController {
private:
    actionlib::SimpleActionClient<control_msgs::FollowJointTrajectoryAction> gripper_action_client_;

public:
    GripperController() : gripper_action_client_("gripper_controller/follow_joint_trajectory", true) {
        gripper_action_client_.waitForServer();
    }

    void setGripper(double position) {
        control_msgs::FollowJointTrajectoryGoal goal;

        // Define joint names
        goal.trajectory.joint_names.push_back("l_gripper_finger_joint");
        goal.trajectory.joint_names.push_back("r_gripper_finger_joint");

        // Define a single point trajectory
        trajectory_msgs::JointTrajectoryPoint point;
        point.positions.push_back(position);
        point.positions.push_back(position);
        point.time_from_start = ros::Duration(1.0); // 1 second duration
        goal.trajectory.points.push_back(point);

        // Send the goal
        gripper_action_client_.sendGoal(goal);
    }

    void openGripper() {
        setGripper(0.1); // Adjust the value based on your robot's gripper open position
    }

    void closeGripper() {
        setGripper(0.0); // Adjust the value based on your robot's gripper closed position
    }
};
