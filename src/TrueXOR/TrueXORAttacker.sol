// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
//CREDITS -viking71
import "./TrueXOR.sol";

// This challenge can be solved through setting the p and q with different bool values like 1 and 0 or 0 and 1 respectively,
// because through this the callMe function returns true. But p and q are output of same function giveBool(). When a transaction is made
// only gas value changes. This means when callMe function is executed each instruction during the execution takes different as amount.
// By processing the gas value we can achieve our goal. Let's say when first time giveBool function is called gas value is x and second time it is y.
// to get the bool value we can shift the gas() value while executing the giveBool function to left and then right with 255 bits.
contract Attack {
    function giveBool() external view returns (bool) {
        bool res;
        assembly {
            res := shr(255, shl(255, gas()))
        }
        return res;
    }
}
