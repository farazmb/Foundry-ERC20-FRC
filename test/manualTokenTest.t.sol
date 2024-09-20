//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import "../src/ManualToken.sol";

contract ManualTokenTest is Test {
    address recipient = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    ManualToken token;

    function setUp() public {
        token = new ManualToken();
        token.transfer(address(this), 50 ether);
    }

    function testTotalSupply() public view {
        assertEq(token.totalSupply(), 100 ether);
    }

    function testDecimals() public view {
        assertEq(token.decimals(), 18);
    }

    function testBalanceof() public {
        assertEq(token.balanceOf(address(this)), 100 ether);
    }

    function testTransfer() public {
        uint256 senderInitialBalance = token.balanceOf(address(this));
        uint256 recipientInitialBalance = token.balanceOf(recipient);

        token.transfer(recipient, 10 ether);

        assertEq(
            token.balanceOf(address(this)),
            senderInitialBalance - 10 ether
        );

        assertEq(
            token.balanceOf(recipient),
            recipientInitialBalance + 10 ether
        );

        assertEq(
            (senderInitialBalance + recipientInitialBalance),
            token.balanceOf(address(this)) + token.balanceOf(recipient)
        );
    }

    function testInsufficientBalanceTransfer() public {
        vm.expectRevert();
        token.transfer(address(this), 1111100 ether);
    }

    function testSelfTransfer() public {
        uint256 initialBalance = token.balanceOf(address(this));
        token.transfer(address(this), 10 ether);
        assertEq(token.balanceOf(address(this)), initialBalance);
    }

    function testZeroBalanceCheck() public {
        uint256 initialSenderBalance = token.balanceOf(address(this));
        uint256 initialRecipientBalance = token.balanceOf(recipient);

        token.transfer(recipient, 0 ether);

        assertEq(token.balanceOf(address(this)), initialSenderBalance);
        assertEq(token.balanceOf(recipient), initialRecipientBalance);
    }

    function testZeroAddress() public {
        token.transfer(address(0), 10 ether);
        vm.expectRevert();
        require(recipient != address(0), "Invalid address: zero address");
        //  vm.expectRevert();
    }
}
//10000000000000000000000
