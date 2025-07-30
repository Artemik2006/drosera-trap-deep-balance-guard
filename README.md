# 🦤 Drosera Trap — Deep Balance Guard

This repository contains a **custom Drosera trap** designed to monitor suspicious balance changes and trigger a custom response function.

---

## 🎯 Objective

Deploy a working trap–response pair to apply for the 🪖 **Sergeant** role in the Drosera testnet (Hoodi).
This trap monitors balance anomalies and invokes the `logAnomaly` function on a custom response contract.

---

## ⚙️ Trap Logic

### 📦 Trap Contract: `DeepBalanceGuard`

Monitors the native ETH balance of a target address across blocks. If the balance changes unexpectedly between two sampled blocks, the trap triggers a response.

### 🧠 Response Contract: `TriggerSignalVault`

Simple contract that emits an alert log when the trap is triggered.

### Response Function

```solidity
function logAnomaly(string calldata message) external
```

---

## 🔍 Smart Contracts

### 🦤 Trap Contract: `DeepBalanceGuard.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITrap {
    function collect() external returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external view returns (bool, bytes memory);
}

contract DeepBalanceGuard is ITrap {
    // 👇 Replace this with the actual address you want to monitor
    address public constant target = 0x1111111111111111111111111111111111111111;

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
```

---

### 📣 Response Contract: `TriggerSignalVault.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TriggerSignalVault {
    event Alert(string message);

    function logAnomaly(string calldata message) external {
        emit Alert(message);
    }
}
```

---

## 🚀 Deployment

### 1. Deploy the Trap

```bash
forge create src/DeepBalanceGuard.sol:DeepBalanceGuard \
  --rpc-url https://ethereum-hoodi-rpc.publicnode.com \
  --private-key <YOUR_PRIVATE_KEY>
```

### 2. Deploy the Response Contract

```bash
forge create src/TriggerSignalVault.sol:TriggerSignalVault \
  --rpc-url https://ethereum-hoodi-rpc.publicnode.com \
  --private-key <YOUR_PRIVATE_KEY>
```

> ✅ **Note:** Save the deployed addresses and use them in the config below.

---

## ⚙️ drosera.toml Example

```toml
ethereum_rpc = "https://ethereum-hoodi-rpc.publicnode.com"
drosera_rpc = "https://relay.hoodi.drosera.io"
eth_chain_id = 560048
drosera_address = "0x91cB447BaFc6e0EA0F4Fe056F5a9b1F14bb06e5D"

[traps]

[traps.deep_balance_guard]
path = "out/DeepBalanceGuard.sol/DeepBalanceGuard.json"
address = "0xYOUR_DEPLOYED_TRAP_ADDRESS"
response_contract = "0xYOUR_DEPLOYED_RESPONSE_CONTRACT"
response_function = "logAnomaly"
block_sample_size = 10
cooldown_period_blocks = 1
min_number_of_operators = 1
max_number_of_operators = 2
private_trap = true
whitelist = ["0xYOUR_EOA_ADDRESS"]
```

---

## 🔮 Apply the Configuration

```bash
DROSERA_PRIVATE_KEY=0xYOUR_PRIVATE_KEY drosera apply
```

---

## 🔗 Explorer Links (Example)

* [Trap Contract](https://hoodi.etherscan.io/address/0xd9DAA8c3CC97ACfAB8001A24A99649eFfF135fED)
* [Response Contract](https://hoodi.etherscan.io/address/0x7f91552D9d793d22b9135723FFcbF211BEAEF5c1)

---

## ✅ Notes

* Be sure to replace placeholder values (addresses, keys) before submitting your application.
* Use `forge build` and `cast call` to verify deployments and ABI compatibility.

---

Made with ❤️ for Drosera Testnet.
