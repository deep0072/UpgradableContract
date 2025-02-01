// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract ImplementationV1 {
    mapping (address => uint256) public stakingBalance;
    uint256 public totalStaked;
    address implementationContract;

    

   

    function stake(uint256 _amount) public payable{
        require(_amount > 0, "amount cant be less than 0");
        require(_amount == msg.value, "amount should be equal to eth you are sending");
     
        stakingBalance[msg.sender]+=_amount;
        totalStaked+=_amount;
    }

    function unstake(uint256 _amount) external {
        require(stakingBalance[msg.sender] >= _amount, "not enough balance");
        stakingBalance[msg.sender]-=_amount;
        totalStaked-=_amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "ETH transfer failed"); // ✅ Revert on failure
        


    }
}