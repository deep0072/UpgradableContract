// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Stake} from "../src/Stake.sol";
import {ImplementationV1} from "../src/ImplementationV1.sol";
import {ProxyContract} from "../src/ProxyContract.sol";
import {console} from "forge-std/console.sol";
contract StakeTest is Test {
    ProxyContract proxyContract;
    Stake stakeContract;
    ImplementationV1 implementationV1;
    receive() external payable {}

    function setUp() public {

        proxyContract = new ProxyContract();
        implementationV1 = new ImplementationV1();
        stakeContract = new Stake();



    }

    // function testStake() public {
    //     uint256 _amount = 20 ether;

    //     stakeContract.stake{value:_amount}(_amount);
    //     console.log("%s %s",_amount,stakeContract.totalStaked() );
    //     assert(stakeContract.totalStaked()== _amount);
    // }
    // function testUnstake() public {
    //     uint256 _amount = 20 ether;
    //     vm.startPrank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
    //     vm.deal(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, _amount);
    //     stakeContract.stake{value:_amount}(_amount);
    //     stakeContract.unstake(_amount);
    //     console.log(stakeContract.totalStaked());
    //     assert(stakeContract.totalStaked() == _amount/2);
    // }


    // function testSwitchImplementionV1() public {
    //     uint256 _amount = 90 ether;
    //     // fist switch to implementationv1
    //     proxyContract.setImplementation(address(implementationV1));
    //     assert(address(implementationV1) == proxyContract.implementationContract());

    //     // now call stake function via fallback function from proxycontract

    // }
    function testStakeOnImplementionV1() public {
        uint256 _amount = 90 ether;
        vm.startPrank(address(this));
        vm.deal(address(this), _amount);

        console.log("balance of this proxyContract before unstaking ",address(proxyContract).balance);
        // fist switch to implementationv1
        proxyContract.setImplementation(address(implementationV1));
        assert(address(implementationV1) == proxyContract.implementationContract());

        // now call stake function via fallback function from proxycontract
        // first encode the function with args
        console.log("balance of this contract before staking original sender ",address(this).balance);
        bytes memory data = abi.encodeWithSignature("stake(uint256)", _amount);
        (bool success,)=address(proxyContract).call{value:_amount}(data);
        assert(success);

        // now call unstake function via fallback function from proxycontract
        // first encode the function with args
        assert(proxyContract.totalStaked() == _amount);
        console.log("total staked token",proxyContract.totalStaked());
        console.log("balance of original sender after staking ",address(this).balance);
         console.log("balance of staking contract after staking",proxyContract.stakingBalance(address(this)));
        // bytes memory data2 = abi.encodeWithSignature("unstake(uint256)", _amount);
        // address(proxyContract).call{value:_amount}(data2);

        (bool success2, bytes memory data2) = address(proxyContract).call(abi.encodeWithSignature("unstake(uint256)",_amount));
        console.log("balance of original sender after unstaking ",address(this).balance);
        console.log("balance of this proxyContract after unstaking ",address(proxyContract).balance);
        console.log("balance of original stakingBalnce after unstaking",proxyContract.stakingBalance(address(this)));





    }
  
}
