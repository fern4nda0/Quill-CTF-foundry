// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/WETH10/WETH10.sol";
import "../src/WETH10/Bob.sol";

contract WETHAttack is Test {
    WETH10 public weth;
    Bob public attacker;
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
        console.log("WETH10ADDRESS: %s ", address(weth));

        console.log("BOBADDRESS: %s ", address(bob));
        uint256 bobBalance = address(bob).balance;
        console.log("BLANCEBOB %s", bobBalance);

        vm.startPrank(bob);
        attacker = new Bob(address(bob), address(weth));
        vm.label(address(attacker), "AttackerContract");
        attacker.deposit{value: bobBalance}();
        // weth.deposit{value: bobBalance}();
        // weth.transfer(address(attacker), bobBalance);
        // weth.approve(address(attacker), type(uint256).max);

        // we get the loan to a contract transfer 1 eth to bob
        attacker.attack();
        // deposit one eth
        // weth.deposit{value: 1 ether}();

        vm.stopPrank();
        assertEq(address(weth).balance, 0, "empty weth contract");
        assertEq(bob.balance, 11 ether, "player should end with 11 ether");
    }
}
