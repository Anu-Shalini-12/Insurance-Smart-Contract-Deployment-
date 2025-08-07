# 🛡️ Insurance Smart Contract Deployment & Transaction Tracking (Local Environment)

## 📘 Project Overview

This project demonstrates the deployment and simulation of an **Insurance Smart Contract** in a **local Ethereum environment** using **Remix IDE**. It showcases end-to-end policy management, including premium payments, claim submissions, approvals, and payouts.

---

## ⚙️ Setup & Environment

### 🔧 Development Tools

| Tool        | Purpose                                                  |
|-------------|----------------------------------------------------------|
| **Remix IDE** | Solidity development, compilation, and deployment       |
| **Local Ethereum Network** | Simulated via Remix’s JavaScript VM or custom Ganache setup |

### 🧪 Environment Summary

- Contract was **written, compiled, and deployed** via Remix IDE.  
- Deployment tested successfully on **Remix local test network**.  
- All transaction logs and emitted events were verified via Remix’s console.

---

## 🧠 Smart Contract: `InsuranceContract.sol`

### 💼 Core Functionalities

| Function | Description |
|----------|-------------|
| `issuePolicy(address _policyHolder, uint _premium, uint _coverageAmount, uint _duration)` | Issues a new policy with the specified parameters |
| `payPremium(uint _policyId)` | Allows the policyholder to pay their premium |
| `submitClaim(uint _policyId, uint _claimAmount, string calldata _reason)` | Lets policyholders submit claims for their policies |
| `approveClaim(uint _claimId)` | Enables the insurer to approve submitted claims |
| `payClaim(uint _claimId)` | Transfers approved claim amount to the policyholder |

---

## 🚀 Deployment & Transactions

### 🔨 Deployment

- Contract was deployed successfully using **Remix Web3 provider**.  
- **Gas fees** were logged and deducted from the deployer account.  
- Transaction details were tracked in **Remix transaction logs**.

### 🔄 Transaction Flow

| Action        | Function        | Description                                  |
|---------------|------------------|----------------------------------------------|
| 📝 Issue Policy | `issuePolicy()` | Admin issues policies to various users        |
| 💰 Pay Premium  | `payPremium()`  | Policyholders pay premiums to activate cover |
| 📤 Submit Claim | `submitClaim()` | Claims raised by users after policy activation |
| ✅ Approve Claim | `approveClaim()` | Insurer approves claims based on rules        |
| 💸 Pay Claim     | `payClaim()`    | Insurer transfers funds to policyholders      |

### 📑 Transaction Logs

- Transactions verified using **Remix IDE logs**  
- Tracked:
  - Gas usage  
  - Sender & receiver addresses  
  - Transaction hashes  
  - Contract state changes  

---

## 📊 Event Tracking & Verification

### 📌 Emitted Events

| Event            | Triggered By      | Purpose                                |
|------------------|------------------|----------------------------------------|
| `PolicyIssued`   | `issuePolicy()`   | Confirms a new policy was issued       |
| `PremiumPaid`    | `payPremium()`    | Confirms premium payment received      |
| `ClaimSubmitted` | `submitClaim()`   | Confirms claim was submitted           |
| `ClaimApproved`  | `approveClaim()`  | Confirms insurer has approved a claim  |
| `ClaimPaid`      | `payClaim()`      | Confirms claim payout was made         |

### 🧾 Local Network Tracking

- All transactions and balance changes were visible on:
  - Remix's console logs  
  - Local network history (e.g., via Ganache or Remix VM)  
- **Gas usage** logged for all state-changing operations

---

## ✅ Conclusion

| Achievement        | Description                                                  |
|--------------------|--------------------------------------------------------------|
| 📦 Deployment       | Smart contract successfully deployed to a local test network |
| 🔁 Full Workflow     | All critical insurance operations tested end-to-end          |
| 💸 Gas Optimization | Gas fees logged only for state-changing actions              |
| 📢 Event Tracking    | Emitted events verified for transparency and traceability   |

---


