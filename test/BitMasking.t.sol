// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {EVMStoragePackedSlotBytes} from "../src/BitMasking.sol";

contract CounterTest is Test {
    EVMStoragePackedSlotBytes public bitMasking;

    function setUp() public {
        bitMasking = new EVMStoragePackedSlotBytes();
    }

    function test_First() public {
        bytes32 result = bitMasking.get();
        bytes32 itShouldBe = bytes32(
            0x0000000000000000000000000000000000000000000000000000cdcdabababab
        );
        assertEq(result, itShouldBe);
    }

    // function testFuzz_SetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }
}
