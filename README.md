# 🚨 Drosera Trap — Deep Balance Guard

This repository contains a custom trap for Drosera designed to trigger on suspicious balance behavior and call a custom response function `logAnomaly`.

---

## 🎯 Objective

Deploy a custom trap to apply for the 🪖 Sergeant role in Drosera. This trap monitors balance changes and invokes a unique response contract.

---

## ⚙️ Trap Logic

**Trap Contract:** `DeepBalanceGuard`  
**Response Contract:** `TriggerSignalVault`  
**Response Function:** `logAnomaly(string)`

---

## 🧠 Smart Contracts

### Trap Contract (`DeepBalanceGuard`)
> Monitors balance differences and triggers based on internal conditions.

### Response Contract (`TriggerSignalVault`)
```solidity
event Alert(string message);

function logAnomaly(string calldata message) external {
    emit Alert(message);
}
