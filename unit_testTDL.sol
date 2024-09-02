// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol"; // Import Remix testing library
import "./toDoList.sol";  // Import the ToDoList contract

contract ToDoListTest {
    ToDoList todoList;

    // Before each test, deploy a new instance of the contract
    function beforeEach() public {
        todoList = new ToDoList();
    }

    // Test the addTask function
    function testAddTask() public {
        todoList.addTask("Task 1");

        // Verify the task count
        uint taskCount = todoList.getTaskCount();
        Assert.equal(taskCount, 1, "Task count should be 1");

        // Verify the task details
        (string memory description, bool isCompleted) = todoList.getTask(0);
        Assert.equal(description, "Task 1", "Task description should match");
        Assert.equal(isCompleted, false, "Task should not be completed initially");
    }

    // Test the completeTask function
    function testCompleteTask() public {
        todoList.addTask("Task 1");

        // Mark the task as completed
        todoList.completeTask(0);

        // Verify the task details
        (, bool isCompleted) = todoList.getTask(0);
        Assert.equal(isCompleted, true, "Task should be marked as completed");
    }

    // Test the getTaskCount function
    function testGetTaskCount() public {
        todoList.addTask("Task 1");

        // Verify the task count
        uint taskCount = todoList.getTaskCount();
        Assert.equal(taskCount, 1, "Task count should be 1 after adding one task");
    }

    // Test the getTask function
    function testGetTask() public {
        todoList.addTask("Task 1");

        // Verify the task details
        (string memory description, bool isCompleted) = todoList.getTask(0);
        Assert.equal(description, "Task 1", "Task description should match");
        Assert.equal(isCompleted, false, "Task should not be completed initially");
    }

function testDeleteTask() public {
    todoList.addTask("Task 1");
    todoList.addTask("Task 2");

    // Delete the first task
    todoList.deleteTask(0);

    // Verify the task count
    uint taskCount = todoList.getTaskCount();
    Assert.equal(taskCount, 1, "Task count should be 1 after deletion");

    // Verify the remaining task
    (string memory description, bool isCompleted) = todoList.getTask(0);
    Assert.equal(description, "Task 2", "Remaining task should be 'Task 2'");
    Assert.equal(isCompleted, false, "Remaining task should not be completed");
}
}
