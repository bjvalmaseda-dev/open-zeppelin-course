// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/AccessControlChallenge.sol";
import {Utilities} from "./utils/Utilities.sol";

contract AccessControlChallengeTest is Test {
    AccessControlChallenge public access;
    Utilities public utils;

    address payable internal alice;
    address payable internal bob;

    function setUp() public {
        utils = new Utilities();
        access = new AccessControlChallenge();

        // Create a user
        address payable[] memory users = utils.createUsers(2);

         // Assign the user 0 as Alice
        alice = users[0];
        bob = users[1];
        vm.label(alice, "Alice");
        vm.label(bob, "Bob");
       
    }

    function testOnlyAdminCanWriter() public {
        //the owner is admin
        access.addWriter(bob);

        // Alice can't add writer
        vm.startPrank(alice);
        vm.expectRevert(bytes("You must be ADMIN to execute this function"));
        access.addWriter(bob);
    }

    function testOnlyWriterCanUseStore() public{
        access.addWriter(bob);
        vm.startPrank(bob);
        access.store(1);
    }

    function testNotWriterCantUseStore() public{
        vm.startPrank(alice);
        vm.expectRevert(bytes("You must be WRITER to execute this function"));
        access.store(1);
    }
}