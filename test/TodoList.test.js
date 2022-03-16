const { assert } = require("chai");

const TodoList = artifacts.require('./TodoList.sol');

contract('TodoList',(accounts)=>{
    before (async ()=>{
        this.todoList = await TodoList.deployed();
    })
    it('deployed succesfully',async ()=>{
        const address = await this.todoList.address
        assert.notEqual(address,0x0);
        assert.notEqual(address,'');
        assert.notEqual(address,null);
        assert.notEqual(address,undefined);


    });
    it('list task',async ()=>{
        const taskCount = await this.todoList.taskCount();
        const task = await this.todoList.tasks(taskCount);
        assert.equal(task.id.toNumber(), taskCount.toNumber());
        assert.equal(task.content,'learn fundamentasl from ethereum.org');
        assert.equal(task.completed,false);
        assert.equal(taskCount.toNumber(),1);
    })
})