# 🔒 Drosera Trap – Deep Balance Guard

This repository contains a **custom trap** for Drosera designed to trigger on suspicious balance behavior and call a custom response function `logAnomaly`.

## ✅ Goal

Apply for **Sergeant** role in Drosera by deploying a unique trap with a custom response contract and verifying successful execution.

---

## 🧠 Response Contract

- **Name:** `TriggerSignalVault`
- **Function:** `logAnomaly()`
- **Address:** `0xA20A3C0a6F022212E432f59DC24a02CC8cE3B25C`

---

## 🕵️ Trap Details

- **Trap Address:** `0xd9DAA8c3CC97ACfAB8001A24A99649eFfF135fED`
- **Response Function Triggered:** ✅ Yes (see screenshots)
- **Confirmed Block:** `882483`
- **Seed Node:** `hoodi`
- **Cooldown:** 10,000 blocks
- **Whitelisted Operator:** `0xDB34AAaA0a0495Dc47C4898391d4D9cF6957d0F1`

---

## 📸 Screenshots

Located in the `screenshots/` folder:

- ✅ `logs-trap-success.png`: confirmation of `ShouldRespond=true`
- ⛓ `block-confirmation.png`: matching trap and block confirmation from Drosera logs

---

## 📄 Files Included

- `src/TriggerSignalVault.sol` – custom response contract
- `drosera.toml` – trap configuration
- `out/` – compiled contract artifacts
- `screenshots/` – logs and visual confirmations

---

## 🔗 Etherscan Link

- [Tx Hash](https://hoodi.etherscan.io/tx/0x15079f63427efa6d84d10211aee7252800c2b9ecf50950026727c15ee21314d7)
