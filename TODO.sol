// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract TODO {
    struct Todo {
        string name;
        bool done;
        bool exists;
    }

    Todo[] public todos;
 
    //return array all todos
    function list() public view returns(Todo [] memory){
        return todos;
    }

    // add todo to array
    function add(string calldata name) public {
        Todo memory addme;
        addme.name = name;
        addme.done = false;
        addme.exists = true;
        todos.push(addme);
    }

    // mark todo with id as done - can be marked once
    function markDone(uint id) public returns(bool) {
        require(todos[id].exists, "id invalid"); // verify id
        require(false == todos[id].done, "todo already marked done");
        todos[id].done = true;
        return true;
    }
}