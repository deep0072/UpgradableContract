// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ProxyContract {

    mapping  (address => uint256) public  stakingBalance;
    uint256 public totalStaked;
    address public implementationContract;
    
    fallback() external payable{
        (bool success, )=implementationContract.delegatecall(msg.data);
        require(success, "something went wrong");
    }

    
    function setImplementation(address _implementionContract) public{
        implementationContract = _implementionContract;

    }

   
    constructor(){

    }


    

    
  
}
