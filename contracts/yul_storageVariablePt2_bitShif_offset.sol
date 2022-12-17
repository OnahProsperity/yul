// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

contract StoragePart2 {
    uint128 public A = 1;     // 16 bytes
    uint96  public B = 2;     // 12 bytes
    uint16  public C = 4;     // 2 bytes
    uint8   public D = 5;     // 1 bytes
    
    // sum in a slot 0 =      32 bytes

    function loadYulSlotInBytes(uint256 slot) external view returns(bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function getOffsetA() external pure returns (uint256 slot, uint256 offset) {
        assembly {
            slot := A.slot
            offset := A.offset
        }
    }

    function getOffsetB() external pure returns (uint256 slot, uint256 offset) {
        assembly {
            slot := B.slot
            offset := B.offset
        }
    }

    function getOffsetC() external pure returns (uint256 slot, uint256 offset) {
        assembly {
            slot := C.slot
            offset := C.offset
        }
    }

    function getOffsetD() external pure returns (uint256 slot, uint256 offset) {
        assembly {
            slot := D.slot
            offset := D.offset
        }
    }


    function loadYul(uint256 slot) external view returns(uint256 ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function loadInBytes(uint256 value) external pure returns(bytes32 ret) {
        ret = bytes32(value);
    }

    // NEVER DO THIS IN PRODUCTION
    function storeYulVal(uint256 slot, uint256 newValue) external {
        assembly {            
            sstore(slot, newValue)
        }
    }

    // masks can be hardcoded because variable storage slot and offsets are fixed
    // V and 00 = 00
    // V and FF = V
    // V or  00 = V
    function writeToC(uint16 newC) external {
        assembly {
            // newC = 0x0000000000000000000000000000000000000000000000000000000000000008
            let loadC := sload(C.slot) // slot 0
            // c = 0x0105000400000000000000000000000200000000000000000000000000000001
            let clearedC := and(
                   loadC,
                   0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            )
            // mask     = 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            // c        = 0x0105000400000000000000000000000200000000000000000000000000000001
            // clearedC = 0x0105000000000000000000000000000200000000000000000000000000000001
            let shiftedNewC := shl(mul(C.offset, 8), newC)
            // shiftedNewE = 0x0000000800000000000000000000000000000000000000000000000000000000
            let newVal := or(shiftedNewC, clearedC)
            // shiftedNewC = 0x0000000800000000000000000000000000000000000000000000000000000000
            // clearedC    = 0x0105000000000000000000000000000200000000000000000000000000000001
            // newVal      = 0x0105000800000000000000000000000200000000000000000000000000000001
            sstore(C.slot, newVal)
        }
    }

    // yet to be completed
    function readOffset(uint256 offset) external view returns (uint256 ret) {
        assembly {
            // can read any variable from same slot on the offset
            let value := sload(C.slot) // must load in 32 byte increments
            // E.offset = 28
            // 1 bytes == 8 bits
            let shifted := shr(mul(offset, 8), value)
            ret := and(0xffff, shifted)
        }
    }

    function readOffsetC() external view returns (uint256 ret) {
        assembly {
            let value := sload(C.slot) // must load in 32 byte increments
            // 0x0005000400000000000000000000000200000000000000000000000000000001
            // E.offset = 28
            // 1 bytes == 8 bits
            let shifted := shr(mul(C.offset, 8), value)
            // 0x0000000000000000000000000000000000000000000000000000000000010008
            // equivalent to
            // 0x000000000000000000000000000000000000000000000000000000000000ffff
            ret := and(0xffff, shifted)
        }
    }
}
