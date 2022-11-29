// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract Operations {

    function isPrime(uint256 x) public pure returns (bool p) {
        p = true;

        assembly {
            // uint256 halfX = x / 2 + 1;
            let halfX := add(div(x, 2), 1)
            //    init          Condition     post-iteration
            for {let i := 2 }  lt(i, halfX)  { i := add(i, 1)} 
            {
                if iszero(mod(x, i)) {
                    p := 0
                    break
                }
            }
        }
    }

    // a + b: integer result of the addition modulo 2 pow 256.
    function checkAdd(uint256 a, uint256 b) external pure returns(uint256 c) {
        assembly {
            c := add(a,b)
        }
    }

    // a // b: integer result of the integer division. If the denominator is 0, the result will be 0.
    function checkDiv(uint256 a, uint256 b) external pure returns(uint256 c) {
        assembly {
            c := div(a,b)
        }
    }

    // a < b: 1 if the left side is smaller, 0 otherwise.
    function checkLt(uint256 a, uint256 b) external pure returns(uint256 c) {
        assembly {
            c := lt(a,b)
        }
    }

    // a % b: integer result of the integer modulo. If the denominator is 0, the result will be 0.
    function checkMod(uint256 a, uint256 b) external pure returns(uint256 c) {
        assembly {
            c := mod(a,b)
        }
    }


    // a == 0: 1 if a is 0, 0 otherwise.
    function checkZero(uint256 a) external pure returns(bool c) {
        assembly {
            c := iszero(a) // is 0 == 0 : true; is 1 == 0 : No (False)
        }
    }

    function checkZeroBytes32(uint256 a) external pure returns(bytes32 c) {
        assembly {
            c := iszero(a)
        }
    }

    function isTruthy() external pure returns (uint256 result) {
        result = 2;
        assembly {
            if 2 { // Where all of the bits inside bytes32 is not zero == true
                result := 1
            }
        }

        return result; // returns 1
    }

    function isFalsy() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if 0 {     // Where all of the bits inside bytes32 is zero == false
                result := 2
            }
        }

        return result; // returns 1
    }

    function negation() external pure returns (uint256 result) {
        result = 1;
        assembly {
            if iszero(0) {
                result := 2
            }
        }

        return result; // returns 2
    }

    function max(uint256 x, uint256 y) external pure returns (uint256 maximum) {
        assembly {
            if lt(x, y) {
                maximum := y
            }
            if iszero(lt(x, y)) {
                // there are no else statements
                maximum := x
            }
        }
    }

    function checkSwitch(uint256 x, uint256 y) external pure returns (uint256 lesser) {
        uint256 sum;
        assembly {
            sum := add(x,y)

            switch lt(x, y)
            case true {
                // do something
                lesser := x
            }
            case false {
                // do something else
                lesser := y
            }
            default {
                // this is not allowed
                lesser := sum
            }
        }
    }

    // Because There is no while loop…
    // But for loops can be written so that they behave like while loops.
    function CheckWhile() external pure returns (uint256 result) {
        assembly {            
            //    init          Condition     post-iteration
            for { let i := 0 } lt(i, 10)     { i := add(i, 1) } 
            {   // while(i < 10)
                result := add(result, i)                
            }
        }
    }

}