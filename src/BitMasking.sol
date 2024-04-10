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
