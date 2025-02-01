// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Stake {

    mapping (address => uint256) stakingBalance;
    uint256 public totalStaked;
    address implementationContract;

    constructor(){

    }

    function stake(uint256 _amount) public payable{
        require(_amount > 0, "amount cant be less than 0");
        require(_amount == msg.value, "amount should be equal to eth you are sending");
     
        stakingBalance[msg.sender]+=_amount;
        totalStaked+=_amount;



    }


    
    function unstake(uint256 _amount) public{
        require(stakingBalance[msg.sender] >= _amount, "not enough balance");
     
        stakingBalance[msg.sender]-=_amount/2;
        totalStaked-=_amount/2;    

        payable(msg.sender).transfer(_amount);



    }
}
