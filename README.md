# 🪤 Drosera Trap — Deep Balance Guard

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
