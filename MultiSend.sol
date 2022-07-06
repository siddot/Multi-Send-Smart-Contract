//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract MultiSend{
    // send salaries
    //1. get job -> 2. add to the list of employers -> every minute send salary(0.5 eth)
    address public owner;
    address payable[] public employees;
    function receiveMoney() public payable onlyOwner {
        require(msg.value > 5 ether);

    }
    uint256 public salaryAmout = 500000000000000000;

    constructor(){
        owner = msg.sender;
    }

    function getEmployees() public view returns (address payable[] memory){
        return employees;
    }

    function addEmployee(address payable _employee) public onlyOwner {
        employees.push(_employee);
    }

    function PaySalary() public onlyOwner{
        require(address(this).balance > employees.length * salaryAmout, "Not enough money to pay salary");
        for(uint i=0;i<employees.length;i++){
            employees[i].transfer(salaryAmout);
        }
    }

    
    function getSalaryBalance() public view returns(uint){
        return address(this).balance;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only Owner can do that");
        _;
    }
}