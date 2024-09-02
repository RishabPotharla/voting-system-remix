// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "./toDoList.sol";

contract ToDoListIntegrationTest {
    ToDoList todoList;

    // Deploy a new instance of the contract before each test
    function beforeEach() public {
        todoList = new ToDoList();
    }

    // Test adding, completing, and deleting tasks together
    function testAddCompleteDeleteTasks() public {
        // Add tasks
        todoList.addTask("Task 1");
        todoList.addTask("Task 2");
        todoList.addTask("Task 3");

        // Verify that 3 tasks have been added
        Assert.equal(todoList.getTaskCount(), 3, "Task count should be 3");

        // Complete the second task
        todoList.completeTask(1);

        // Verify that the second task is marked as completed
        (, bool isCompleted) = todoList.getTask(1);
        Assert.equal(isCompleted, true, "Task 2 should be completed");

        // Delete the first task
        todoList.deleteTask(0);

        // Verify the task count is now 2
        Assert.equal(todoList.getTaskCount(), 2, "Task count should be 2 after deletion");

        // Verify the remaining tasks
        (string memory description1, ) = todoList.getTask(0);
        (string memory description2, ) = todoList.getTask(1);

        Assert.equal(description1, "Task 3", "First remaining task should be 'Task 3'");
        Assert.equal(description2, "Task 2", "Second remaining task should be 'Task 2'");
    }

    // Additional integration tests can go here
}


