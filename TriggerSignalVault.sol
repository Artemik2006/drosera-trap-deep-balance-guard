// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TriggerSignalVault {
    event Alert(string reason);

    function logAnomaly(string calldata reason) external {
        emit Alert(reason);
    }
}
