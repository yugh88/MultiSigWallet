// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSigWallet {
    // Define the owners and their respective addresses
    address public owner1;
    address public owner2;
    address public owner3;

    // Counter for transaction IDs
    uint256 public transactionIdCounter;

    // Struct to represent a transaction
    struct Transaction {
    uint256 id;
    address destination;
    uint256 amount;
    uint256 approvals;
    address[] approvedBy;
    bool executed;
}

    // Mapping of transaction ID to Transaction
    mapping(uint256 => Transaction) public transactions;

    // Event emitted when a transaction is proposed
    event TransactionProposed(uint256 indexed id, address indexed destination, uint256 amount);

    // Event emitted when a transaction is approved
    event TransactionApproved(uint256 indexed id, address indexed approver);

    // Event emitted when a transaction is executed
    event TransactionExecuted(uint256 indexed id);

    // Modifier to ensure that only owners can call certain functions
    modifier onlyOwners() {
        require(
            msg.sender == owner1 || msg.sender == owner2 || msg.sender == owner3,
            "Not an owner"
        );
        _;
    }

    // Modifier to ensure that a transaction exists
    modifier validTransaction(uint256 _transactionId) {
        require(_transactionId <= transactionIdCounter, "Invalid transaction ID");
        require(!transactions[_transactionId].executed, "Transaction already executed");
        _;
    }

    // Constructor to set the owners and initialize the counter
  
     constructor(address _owner1, address _owner2, address _owner3) {
        owner1 = _owner1;
        owner2 = _owner2;
        owner3 = _owner3;
        transactionIdCounter = 1;
    }


    // Function to propose a transaction
    function proposeTransaction(address _destination, uint256 _amount) external onlyOwners {
        uint256 newTransactionId = transactionIdCounter++;
        transactions[newTransactionId] = Transaction(
    newTransactionId,
    _destination,
    _amount,
    0,
    new address[](0),   // Initialize an empty dynamic array
    false
);

        emit TransactionProposed(newTransactionId, _destination, _amount);
    }

    // Function for owners to approve a transaction
  function approveTransaction(uint256 _transactionId)
    external
    onlyOwners
    validTransaction(_transactionId)
{
    Transaction storage transaction = transactions[_transactionId];
    bool alreadyApproved = false;

    for (uint256 i = 0; i < transaction.approvedBy.length; i++) {
        if (transaction.approvedBy[i] == msg.sender) {
            alreadyApproved = true;
            break;
        }
    }

    require(!alreadyApproved, "Already approved");

    transaction.approvedBy.push(msg.sender);
    transaction.approvals++;

    emit TransactionApproved(_transactionId, msg.sender);

    // Execute the transaction if approved by at least two owners
    if (transaction.approvals >= 2) {
        executeTransaction(_transactionId);
    }
}

    // Internal function to execute a transaction
    function executeTransaction(uint256 _transactionId) internal validTransaction(_transactionId) {
        Transaction storage transaction = transactions[_transactionId];
       require(transaction.approvals >= 2, "Not enough approvals");

        // Transfer funds to the destination address
        require(
            address(this).balance >= transaction.amount,
            "Insufficient funds in the wallet"
        );

        (bool success, ) = transaction.destination.call{value: transaction.amount}("");
        require(success, "Transfer failed");

        // Mark the transaction as executed
        transaction.executed = true;

        emit TransactionExecuted(_transactionId);
    }

    // Function to get the balance of the contract
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

