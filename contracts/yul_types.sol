// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9

;
contract yul_types {
    
    function Uint256() external pure returns (uint256 x) {
        x = 100;
    }

    function getUint256Yul() external pure returns (uint256 x) {
        assembly {
            x := 100
        }
    }

    function getHexInNumber() external pure returns (uint256 x) {
        assembly {
            x := 0x64
        }
    }

    function Bytes32() external pure returns (bytes32 x) {
        return x;
    }

    function Bool() external pure returns (bool x) {
        x = true;
    }

    function Address() external pure returns (address x) {
        x = address(1);
    }

    function AddressInYul() external pure returns (address x) {
        assembly {
            x := 1
        }
    }

    function Strings() external pure returns (string memory x) {
        x = "function string";
    }


    function StringInYul() external pure returns (string memory) {
        bytes32 myString = "";
        assembly {
            myString := "output string"
        }
        return string(abi.encode(myString));
    }

    
}

