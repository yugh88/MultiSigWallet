MultiSig Wallet

Overview

This is a MultiSig (multi-signature) Wallet project built on the Ethereum blockchain. MultiSig wallets add an extra layer of security by requiring multiple approvals to execute transactions. This project includes a series of contracts with increasing complexity, scripts for deploying contracts, and tests to validate functionality.

Directory Structure

This workspace contains three main directories:

	•	contracts: Contains Solidity contracts, with increasing complexity, implementing the MultiSig Wallet’s core functionality.
	•	scripts: Typescript files for deploying the contracts to a blockchain network.
	•	tests: Includes Solidity and JavaScript test files to validate contract functionality.

Getting Started

Prerequisites

Ensure you have the following tools installed:

	•	Node.js and npm: Used for running scripts and managing dependencies.
	•	Hardhat: Ethereum development environment.

Install project dependencies:

npm install

Directory Details

	1.	contracts
	•	Contains the main Solidity contracts for the MultiSig Wallet. Each contract includes varying features and functionality.
	•	Example contracts:
	•	SimpleMultiSig.sol: A basic MultiSig wallet.
	•	EnhancedMultiSig.sol: Adds additional functionality such as transaction limits.
	•	AdvancedMultiSig.sol: Includes advanced features like time-locks and withdrawal limits.
	2.	scripts
	•	Contains TypeScript files to deploy contracts.
	•	Example scripts:
	•	deploySimpleWallet.ts: Deploys the SimpleMultiSig contract.
	•	deployEnhancedWallet.ts: Deploys the EnhancedMultiSig contract.
	•	deployAdvancedWallet.ts: Deploys the AdvancedMultiSig contract.
	•	setupWallet.ts: Sets up wallet configurations after deployment.
	3.	tests
	•	Includes test files for validating the contracts:
	•	BallotTest.sol: Solidity test file for the Ballot contract.
	•	StorageTest.js: JavaScript test file for the Storage contract.

Usage

	1.	Compile the Contracts

npx hardhat compile


	2.	Deploy the Contracts
Run the deployment scripts to deploy the contracts to your preferred network:

npx hardhat run scripts/deploySimpleWallet.ts --network <network-name>

Replace <network-name> with your chosen network (e.g., localhost, Ropsten).

	3.	Run Tests
Execute the test scripts to ensure all contracts function as expected:

npx hardhat test



License

This project is licensed under the MIT License.

This README file provides an introduction, setup instructions, and a breakdown of each directory, which should help users navigate and understand the project. Let me know if you need further customization!
