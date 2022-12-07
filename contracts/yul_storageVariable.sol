// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;


contract Storage {

    uint256 x = 3;    // 32 bytes
    uint256 y = 5;    // 32 bytes
    uint256 z = 7;    // 32 bytes

    uint128 a = 1;     // 16 bytes
    uint128 b = 2;     // 16 bytes

    function storeYulVal(uint256 slot, uint256 newValue) external {
        assembly {            
            sstore(slot, newValue)
        }
    }

    function getSlot() external pure returns(uint256 slot) {
        assembly {
            slot := a.slot
        }
    }

    function loadYulSlotInBytes(uint256 slot) external view returns(bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function loadYul(uint256 slot) external view returns(uint256 ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function getXSlot() external pure returns(uint256 ret) {
        assembly {
            ret := x.slot
        }
    }

    function getYSlot() external pure returns(uint256 ret) {
        assembly {
            ret := y.slot
        }
    }

    function getZSlot() external pure returns(uint256 ret) {
        assembly {
            ret := z.slot
        }
    }

    function setX(uint256 newX) public {
        x = newX;
    }

    function retrieve() public view returns (uint256){
        return x;
    }
    
}