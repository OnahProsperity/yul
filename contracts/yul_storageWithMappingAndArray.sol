// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract StoragePart3 {

    uint256[3] fixedLengthArray;
    uint256[] dynamicArray;
    uint16[] smallArray; // 2 bytes
    mapping(uint256 => uint256) private myMapping;
    mapping(uint256 => mapping(uint256 => uint256)) public nestedMapping;
    mapping(address => uint256[]) public mappingAddressToList;

    constructor() {
        fixedLengthArray = [100,199,465];
        dynamicArray = [100,7,899,999, 4584];
        smallArray = [1, 2, 3];
        myMapping[1] = 10000;
        nestedMapping[1][2] = 8589565;
        mappingAddressToList[0x93f8dddd876c7dBE3323723500e83E202A7C96CC] = [777,7888,55555, 999];
    }

    function readFixedArray(uint256 index) external view returns(uint256 ret) {
        assembly {
            let slot := fixedLengthArray.slot
            ret := sload(add(slot, index))
        }
    }

    function writeToFixedArray(uint256 index, uint256 value) external {
        assembly {
            let slot := fixedLengthArray.slot
            sstore(add(slot, index), value)
        }
    }

    function dynamicArrayLength() external view returns (uint256 ret) {
        assembly {
            ret := sload(dynamicArray.slot)
        }
    }

    function readDynamicArrayLocation(uint256 index) external view returns (uint256 ret) {
        uint256 slot;
        assembly {
            slot := dynamicArray.slot
        }

        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            ret := sload(add(location,index))
        }
    }

    function readSmallArray() external view returns (uint256 ret) {
        assembly {
            ret := sload(smallArray.slot)
        }
    }

    function readSmallArrayLocation(uint256 index) external view returns (bytes32 ret) {
        uint256 slot;
        assembly {
            slot := smallArray.slot
        }

        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            ret := sload(add(location,index))
        }
    }

    function getMappingValue(uint256 key) external view returns (uint256 ret) {
        uint256 slot;
        assembly {
            slot := myMapping.slot
        }

        bytes32 location = keccak256(abi.encode(key, uint256(slot)));

        assembly {
            ret := sload(location)
        }
    }

    function getNestedMapping() external view returns (uint256 ret) {
        uint256 slot;
        assembly {
            slot := nestedMapping.slot
        }      

        bytes32 location = keccak256(
        abi.encode(
            uint256(2),
            keccak256(
                abi.encode(
                    uint256(1), uint256(slot)
                )
            )
        )        
    );
    assembly {
            ret := sload(location)
        }
    }

    function lengthOfNestedMappingList() external view returns (uint256 ret) {
        uint256 addressToListSlot;
        assembly {
            addressToListSlot := mappingAddressToList.slot
        }

        bytes32 location = keccak256(
            abi.encode(
                address(0x93f8dddd876c7dBE3323723500e83E202A7C96CC),
                uint256(addressToListSlot)
            )
        );
        assembly {
            ret := sload(location)
        }
    }

    function getAddressToList(uint256 index)
        external
        view
        returns (uint256 ret)
    {
        uint256 slot;
        assembly {
            slot := mappingAddressToList.slot
        }

        bytes32 location = keccak256(
            abi.encode(
                keccak256(
                    abi.encode(
                        address(0x93f8dddd876c7dBE3323723500e83E202A7C96CC),
                        uint256(slot)
                    )
                )
            )
        );
        assembly {
            ret := sload(add(location, index))
        }
    }

}