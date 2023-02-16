// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Pelusa/Pelusa.sol";
import "../src/Pelusa/PelusaAttacker.sol";

contract PelusaAttack is Test {
    address wojak;
    address manager;
    PelusaAttacker internal pelusaAttacker;
    Pelusa internal pelusaContract;

    function setUp() public {
        //Characters
        manager = makeAddr("manager");
        wojak = address(0xca8fA8f0b631ecDb18cDA619C4fC9d197C0aFFA2);
        // Characters labelling...
        vm.label(manager, "bogdanOff");
        vm.label(wojak, "attacker");

        //Equity
        vm.deal(manager, 0.01 ether);
        vm.deal(wojak, 0.01 ether);

        vm.startPrank(manager);
        // owner is the boggy
        pelusaContract = new Pelusa();

        vm.stopPrank();
    }

    // function testExploit() public {
    //     vm.startPrank(wojak);
    //     console.log("Attacker Address %s", wojak);
    //     pelusaAttacker = new PelusaAttacker();
    //     vm.label(address(pelusaAttacker), "AttackerContract");
    //     pelusaAttacker.attack1();
    //     vm.stopPrank();
    // }
}
