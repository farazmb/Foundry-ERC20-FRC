//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import "../src/OurToken.sol";

contract TestOurToken is Test {
    OurToken token;
    address owner;
    address spender;
    address recipient;
    uint256 initialBalance;
    uint256 amount;

    function setUp() public {
        token = new OurToken(1000 ether);
        owner = address(this);
        spender = 0xFd0F41A06549eaf25AE80F8b5Fcb8524F9b4836c; // Anvil address
        recipient = 0x2286bEd1BCE22f6edA79E75A7Ec4CA18d85cACA6; // Another Anvil address

        // Transfer tokens to owner and spender
        token.transfer(owner, 100 ether);
        token.transfer(spender, 50 ether); // Ensure spender has enough tokens

        initialBalance = token.balanceOf(owner);
        amount = 10 ether;
        token.approve(spender, amount);
    }

    function testInitialSupply() public view {
        assertEq(token.totalSupply(), 1000 ether);
    }

    function testTokenName() public view {
        assertEq(token.name(), "Faraz Coin");
    }

    function testTokenSymbol() public view {
        assertEq(token.symbol(), "FRC");
    }
}
