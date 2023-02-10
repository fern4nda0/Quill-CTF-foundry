// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/RoadClosed/RoadClosed.sol";
import "../src/RoadClosed/RoadAttack.sol";

contract RoadAttackerWithContract is Test {
    RoadAttack internal roadAttack;
    RoadClosed internal roadClosed;
    address attacker;

    function setUp() public {
        roadClosed = new RoadClosed();
        attacker = makeAddr("attacker");
        vm.label(attacker, "Attacker");
        assertEq(roadClosed.isHacked(), false);
    }

    function testAttack() public {
        vm.startPrank(attacker);
        roadAttack = new RoadAttack(address(roadClosed));
        vm.label(address(roadAttack), "AttackerContract");
        vm.stopPrank();
        assertEq(roadClosed.isHacked(), true);
        console.log(unicode"\n Exploit successful 😾!!!!");
    }
}
