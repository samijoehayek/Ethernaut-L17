// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Preservation} from "../src/Preservation.sol";

contract PreservationScript is Script {
    Preservation public preservation =
        Preservation(0xda0DE4010A53Aef225f6408CFcB6B23632B8225C);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        vm.stopBroadcast();
    }
}
