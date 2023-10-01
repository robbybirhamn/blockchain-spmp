// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DocumentLog {
    // Define a struct to represent a JSON log.
    struct JSONLog {
        string[] logData;
        address owner;
    }

    // Mapping to store JSON logs by document ID.
    mapping(uint256 => JSONLog) public logs;

    // Event to log document creation.
    event DocumentCreated(uint256 indexed documentId, string[] logData, address owner);

    // Modifier to check if the caller is the owner of a document.
    modifier onlyDocumentOwner(uint256 documentId) {
        require(msg.sender == logs[documentId].owner, "Only the owner can perform this action");
        _;
    }

    // Function to create a new document log.
    function createDocument(uint256 documentId, string[] memory logData) external {
        require(logData.length > 0, "Log data must not be empty");
        require(logs[documentId].owner == address(0), "Document ID already exists");

        logs[documentId] = JSONLog(logData, msg.sender);

        emit DocumentCreated(documentId, logData, msg.sender);
    }

    // Function to read the log data of a document.
    function readDocument(uint256 documentId) external view returns (string[] memory) {
        return logs[documentId].logData;
    }

    // Function to update the log data of a document (only the owner can update).
    function updateDocument(uint256 documentId, string[] memory newLogData) external onlyDocumentOwner(documentId) {
        require(newLogData.length > 0, "Log data must not be empty");

        logs[documentId].logData = newLogData;
    }
}
