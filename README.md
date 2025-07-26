# 🪤 Drosera Trap — Deep Balance Guard

This repository contains a **custom trap** for Drosera designed to trigger on suspicious balance behavior and call a custom response function `logAnomaly`.

---

## 🎯 Objective

Deploy a custom trap to apply for the 🪖 **Sergeant** role in Drosera.  
This trap monitors balance anomalies and invokes a unique response contract.

---

## ⚙️ Trap Logic

### 📦 Trap Contract: `DeepBalanceGuard`
Monitors balance differences across blocks and triggers based on internal conditions.

### 🧠 Response Contract: `TriggerSignalVault`
Emits log when the trap is triggered.

### Response Function: `logAnomaly(string)`

---

## 🧾 Smart Contracts

### Trap Contract (`DeepBalanceGuard.sol`)
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITrap {
    function collect() external returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external view returns (bool, bytes memory);
}

contract DeepBalanceGuard is ITrap {
    address public constant target = 0xABcDEF1234567890abCknfsdnfjkdsfnuunun2; // change to monitored address

    function collect() external override returns (bytes memory) {
        return abi.encode(target.balance);
    }

    function shouldRespond(bytes[] calldata data) external view override returns (bool, bytes memory) {
        if (data.length < 2) return (false, "Not enough data");

        uint256 current = abi.decode(data[0], (uint256));
        uint256 previous = abi.decode(data[1], (uint256));

        if (current != previous) {
            return (true, "");
        }

        return (false, "");
    }
}


Response Contract (TriggerSignalVault.sol)

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TriggerSignalVault {
    event Alert(string message);

    function logAnomaly(string calldata message) external {
        emit Alert(message);
    }
}
