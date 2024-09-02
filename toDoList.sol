// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ToDoList {
    // Define a task structure with gas optimization by packing variables
    struct Task {
        string description;
        bool isCompleted;
    }

    // Mapping to store tasks associated with each user
    mapping(address => Task[]) private tasks;

    // Event emitted when a new task is added
    event TaskAdded(address indexed user, uint256 taskId, string description);

    // Event emitted when a task is marked as completed
    event TaskCompleted(address indexed user, uint256 taskId);

    // Function to add a new task
    function addTask(string calldata _description) external {
        tasks[msg.sender].push(Task({
            description: _description,
            isCompleted: false
        }));
        emit TaskAdded(msg.sender, tasks[msg.sender].length - 1, _description);
    }

    // Function to mark a task as completed
    function completeTask(uint256 _taskId) external {
        require(_taskId < tasks[msg.sender].length, "Task does not exist");
        tasks[msg.sender][_taskId].isCompleted = true;
        emit TaskCompleted(msg.sender, _taskId);
    }

    // Function to get the number of tasks for a user
    function getTaskCount() external view returns (uint256) {
        return tasks[msg.sender].length;
    }

    // Function to retrieve a task by its ID
    function getTask(uint256 _taskId) external view returns (string memory description, bool isCompleted) {
        require(_taskId < tasks[msg.sender].length, "Task does not exist");
        Task memory task = tasks[msg.sender][_taskId];
        return (task.description, task.isCompleted);
    }

    // Function to get all tasks for a user
    function getAllTasks() external view returns (Task[] memory) {
        return tasks[msg.sender];
    }

    // Function to delete a task (optional for enhanced functionality)
    function deleteTask(uint256 _taskId) external {
        require(_taskId < tasks[msg.sender].length, "Task does not exist");
        uint256 lastIndex = tasks[msg.sender].length - 1;

        // If the task to be deleted is not the last task, swap it with the last task
        if (_taskId != lastIndex) {
            tasks[msg.sender][_taskId] = tasks[msg.sender][lastIndex];
        }

        // Remove the last task (deletes the task)
        tasks[msg.sender].pop();
    }
}
