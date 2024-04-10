// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {EVMStoragePackedSlotBytes, BitMasking} from "../src/BitMasking.sol";

contract BitMaskingTest is Test {
    EVMStoragePackedSlotBytes public slotBytes;
    BitMasking public bitMasking;

    function setUp() public {
        slotBytes = new EVMStoragePackedSlotBytes();
        bitMasking = new BitMasking();
    }

    function test_First() public view {
        bytes32 result = slotBytes.get();
        bytes32 itShouldBe = bytes32(
            0x0000000000000000000000000000000000000000000000000000cdcdabababab
        );
        assertEq(result, itShouldBe);
    }

    function test_Second() public view {
        (bytes32 value1, bytes32 value2) = bitMasking.example_mask();
        bytes32 value1ShouldBe = bytes32(
            0x0000000000000000000000000000000000000000000000000000000000010000
        );
        bytes32 value2ShouldBe = bytes32(
            0x000000000000000000000000000000000000000000000000000000000000ffff
        );
        // console2.logBytes32(value1);
        // console2.logBytes32(value2);
        assertEq(value1, value1ShouldBe);
        assertEq(value2, value2ShouldBe);
    }

    function test_example_shift_mask() public view {
        bytes32 value = bitMasking.example_shift_mask();
        bytes32 valueShouldBe = bytes32(
            0x0000000000000000000000000000000000000000000000000000ffff00000000
        );
        assertEq(value, valueShouldBe);
    }

    function test_example_shift_not_mask() public view {
        bytes32 value = bitMasking.example_shift_not_mask();
        bytes32 valueShouldBe = bytes32(
            0xffffffffffffffffffffffffffffffffffffffffffffffffffff0000ffffffff
        );
        assertEq(value, valueShouldBe);
    }

    // function testFuzz_SetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }
}
