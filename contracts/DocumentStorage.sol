// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DocumentStorage {
    struct Document {
        string documentName;
        string reportID;  // Change reportID to string
        string stepID;    // Change stepID to string
        string note;
        address createdBy; // Ethereum address of the creator
        string hashFileIPFS;
        uint256 timestamp;
    }

    uint256 public documentCount;
    mapping(uint256 => Document) public documents;

    event DocumentAdded(string indexed reportID, string indexed stepID, address indexed createdBy);

    function addDocument(
        string memory _documentName,
        string memory _reportID,
        string memory _stepID,
        string memory _note,
        string memory _hashFileIPFS
    ) public {
        documentCount++;
        documents[documentCount] = Document({
            documentName: _documentName,
            reportID: _reportID,
            stepID: _stepID,
            note: _note,
            createdBy: msg.sender, // Use msg.sender as the creator
            hashFileIPFS: _hashFileIPFS,
            timestamp: block.timestamp
        });

        emit DocumentAdded(_reportID, _stepID, msg.sender);
    }

    function updateDocument(uint256 _documentID, string memory _newHashFileIPFS) public {
        require(_documentID <= documentCount && _documentID > 0, "Invalid document ID");
        Document storage doc = documents[_documentID];
        require(msg.sender == doc.createdBy, "You are not the creator of this document");
        doc.hashFileIPFS = _newHashFileIPFS;
    }

    // Function to read the log data of a document.
    function readDocument(uint256 documentId) external view returns (Document memory) {
        return documents[documentId];
    }

    function getDocumentsByReportID(string memory _reportID) public view returns (Document[] memory) {
        uint256 count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (keccak256(bytes(documents[i].reportID)) == keccak256(bytes(_reportID))) {
                count++;
            }
        }

        Document[] memory result = new Document[](count);
        count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (keccak256(bytes(documents[i].reportID)) == keccak256(bytes(_reportID))) {
                result[count] = documents[i];
                count++;
            }
        }

        return result;
    }

    function getDocumentsByStepID(string memory _stepID) public view returns (Document[] memory) {
        uint256 count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (keccak256(bytes(documents[i].stepID)) == keccak256(bytes(_stepID))) {
                count++;
            }
        }

        Document[] memory result = new Document[](count);
        count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (keccak256(bytes(documents[i].stepID)) == keccak256(bytes(_stepID))) {
                result[count] = documents[i];
                count++;
            }
        }

        return result;
    }

    function getDocumentsByCreatedBy(address _creator) public view returns (Document[] memory) {
        uint256 count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (documents[i].createdBy == _creator) {
                count++;
            }
        }

        Document[] memory result = new Document[](count);
        count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (documents[i].createdBy == _creator) {
                result[count] = documents[i];
                count++;
            }
        }

        return result;
    }

    function getPemilik() public view returns (address) {
        return msg.sender;
    }
}
