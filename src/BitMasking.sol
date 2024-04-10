// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EVMStoragePackedSlotBytes {
    // slot zero is packed from right to left
    //0x00000000...00000000
    //0x00000000...abababab
    bytes4 b4 = 0xabababab;
    //0x00000000...cdcdabababab;
    bytes2 b2 = 0xcdcd;
    //0x0000000000000000000000000000000000000000000000000000cdcdabababab
    //0xffffffffffffffffffffffffffffffffffffffffffffffffffff0000ffffffff

    function get() public view returns (bytes32 b32) {
        assembly {
            b32 := sload(0)
        }
    }
}

contract BitMasking {
    /// @notice Creates mask for bytes32 value that consists of 16 bits of 1 on the left side and the rest are zeros
    /// @dev no comment
    /// @return mask1 between mask
    /// @return mask2 final mask
    // |        256 bits         |
    // 000 ... 000 | 111 ... 111 |
    //             | 16 bits of 1
    function example_mask() public pure returns (bytes32 mask1, bytes32 mask2) {
        assembly {
            // 000 ... 001 | 000 ... 000 -> mask1
            // 000 ... 000 | 111 ... 111 -> mask2
            // 0x000000000000000000000000000000000000000000000000000000000000ffff -> mask2
            mask1 := shl(16, 1)
            mask2 := sub(shl(16, 1), 1)
        }
    }

    /// @notice Creates mask for bytes32 value that consist of 16bits of 1 on the specific place in this value
    /// @dev no comment
    /// @return mask final mask
    // 000 ... 000 | 111  ... 111 | 000 ... 000
    //             | 16 bits of 1 | 32 bits of 0
    function example_shift_mask() public pure returns (bytes32 mask) {
        assembly {
            // 0x0000000000000000000000000000000000000000000000000000ffff00000000 -> mask
            mask := shl(32, sub(shl(16, 1), 1))
        }
    }

    /// @notice Creates NOT mask for bytes32 value that consist of 16bits of 1 on the specific place in this value
    /// @dev no comment
    /// @return mask final mask
    // 111 ... 111 | 000  ... 000 | 111 ... 111
    //             | 16 bits of 0 | 32 bits of 1
    function example_shift_not_mask() public pure returns (bytes32 mask) {
        assembly {
            // 0xffffffffffffffffffffffffffffffffffffffffffffffffffff0000ffffffff -> mask
            mask := not(shl(32, sub(shl(16, 1), 1)))
        }
    }
}
