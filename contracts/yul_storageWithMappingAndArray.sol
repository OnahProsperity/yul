// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract StoragePart3 {
    // Fixed Array
    // Unfixed Array
    // Array with UINT8
    // Mapping
    // Nested Mapping
    // Mapping ==> Array
    // Mapping ==> Struct

    uint256[3] fixedArray;
    uint256 slot0 = fixedArray[0];
    uint256 slot1 = fixedArray[1];
    uint256 slot2 = fixedArray[2];
    uint256 slot3 = fixedArray[3];

    uint256[] unfixedArray;
    uint8[] typeUint8Array;

    mapping (uint256 => uint256) myMapping;


    constructor() {
        fixedArray = [10,80,90];
        unfixedArray = [11,222,333,444,555];
        typeUint8Array = [5,7,8,9];
        myMapping[1] = 10000000;
    }

    function readFixedArray(uint256 index) external view returns(uint256 ret) {
        assembly {
            let slot := fixedArray.slot
            ret := sload(add(slot, index))
        }
    }

    function writeToFixedArray(uint256 index, uint256 value) external {
        assembly {
            let slot := fixedArray.slot
            sstore(add(slot, index), value)
        }
    }

    function readLengthUnFixedArray(uint256 index) external view returns(uint256 ret) {
        assembly {
            let slot := unfixedArray.slot
            ret := sload(add(slot, index))
        }
    }

    function readUnfixedArray(uint256 index) external view returns(uint256 ret) {
        bytes32 slot;
        assembly {
            slot := unfixedArray.slot
        }
        bytes32 location = keccak256(abi.encode(slot));
        assembly {
            ret := sload(add(location, index))
        }
    }

    function readTypeUint8Array(uint256 index) external view returns(bytes32 ret) {
        bytes32 slot;

        assembly {
            slot := typeUint8Array.slot
        }

        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            ret := sload(add(location, index))
        }
    }

    function readMyMapping() external {
        bytes32 slot;
        assembly {
            slot := myMapping.slot
        }
    }

}
