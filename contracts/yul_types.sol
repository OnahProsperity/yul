// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.9;

contract YulTypes {

    function getNumber() external pure returns(uint256) {

        uint256 value;

        assembly {
            value := 100
        }

        return value;
    }

    function getHex() external pure returns(uint256) {

        uint256 value;

        assembly {
            value := 0x64
        }

        return value;
    }


    function getAssignments() external pure returns(bool) {
        bool _rep;

        bytes32 zero = bytes32("2");

        assembly {
            _rep := zero
        }

        return _rep;
    }

    function getString() external pure returns( string memory) {
        bytes32  rep;

        assembly {
            rep := "Hello World"
        }

        return string(abi.encode(rep));
    }

}



