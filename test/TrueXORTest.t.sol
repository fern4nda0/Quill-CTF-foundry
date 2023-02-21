// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/TrueXOR/TrueXORAttacker.sol";

contract TrueXORTest is Test {
    TrueXOR public trueXOR;
    address public attacker;

    function setUp() public {
        attacker = vm.addr(2); // attacker
        trueXOR = new TrueXOR();
    }

    function testExploit() public {
        vm.startPrank(attacker, attacker);
        Attack attack = new Attack();
        bool ans = trueXOR.callMe(address(attack));
        vm.stopPrank();
        assert(ans == true);
    }
}
