// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract Memory {

    struct Point {
        uint256 x;
        uint256 y;
        uint256 z;
    }    

    event MemoryPointer(bytes32);
    event MemoryPointerV2(bytes32, bytes32);
    event Debug(bytes32, bytes32, bytes32, bytes32);

    function readHighValue() external pure {
        assembly {
            // pop just throws away the return value (remove value from stack)
            pop(mload(0xffffffffffffffff))
        }
    }

    function differentMstore() external pure {
        assembly {
            mstore8(0x00, 5)
            mstore(0x00, 5)
        }
    }

    function structMemory() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        Point memory p = Point({x: 1, y: 2, z :3});
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
    }

    function structMemoryV2() external {
        bytes32 x40;
        bytes32 size;
        assembly {
            x40 := mload(0x40)
            size := msize()
        }
        emit MemoryPointerV2(x40, size);
        Point memory p = Point({x: 1, y: 2, z :3});
        assembly {
            x40 := mload(0x40)
            size := msize()
        }
        emit MemoryPointerV2(x40, size);
    }

    function fixedArray() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        uint256[2] memory arr = [uint256(5), uint256(6)];
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
    }

    function abiEncode() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        abi.encode(uint256(5), uint256(6));
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
    }

    function abiEncode2() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        abi.encode(uint256(5), uint128(6));
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
    }

    function abiEncodePacked() external {
        bytes32 x40;
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
        abi.encodePacked(uint256(5), uint128(6), uint8(3));
        assembly {
            x40 := mload(0x40)
        }
        emit MemoryPointer(x40);
    }

    function arrayValues(uint256[] memory arr) external {
        bytes32 location;
        bytes32 len;
        bytes32 valueAtIndex0;
        bytes32 valueAtIndex1;
        assembly {
            location := arr // location of array
            len := mload(arr) // length of array
            valueAtIndex0 := mload(add(arr, 0x20)) // value at first index
            valueAtIndex1 := mload(add(arr, 0x40)) // value at second index
            // ...
        }
        emit Debug(location, len, valueAtIndex0, valueAtIndex1);
    }

    function breakFreeMemoryPointer(uint256[1] memory foo)
        external
        pure
        returns (uint256)
    {
        assembly {
            mstore(0x40, 0x80)
        }
        uint256[1] memory bar = [uint256(6)];
        return foo[0];
    }

}
