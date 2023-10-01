// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract DocumentLogSPMI {
    struct Document {
        string documentName;
        uint256 reportID;
        uint256 stepID;
        string note;
        address createdBy; // Ethereum address of the creator
        string hashFileIPFS;
        uint256 timestamp;
    }

    uint256 public documentCount;
    mapping(uint256 => Document) public documents;

    event DocumentAdded(uint256 indexed reportID, uint256 indexed stepID, address indexed createdBy);

    function addDocument(
        string memory _documentName,
        uint256 _reportID,
        uint256 _stepID,
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

    function getDocumentsByReportID(uint256 _reportID) public view returns (Document[] memory) {
        uint256 count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (documents[i].reportID == _reportID) {
                count++;
            }
        }

        Document[] memory result = new Document[](count);
        count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (documents[i].reportID == _reportID) {
                result[count] = documents[i];
                count++;
            }
        }

        return result;
    }

    function getDocumentsByStepID(uint256 _stepID) public view returns (Document[] memory) {
        uint256 count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (documents[i].stepID == _stepID) {
                count++;
            }
        }

        Document[] memory result = new Document[](count);
        count = 0;
        for (uint256 i = 1; i <= documentCount; i++) {
            if (documents[i].stepID == _stepID) {
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

    function getPemilik() public view returns(address){
            return msg.sender;
        }
}
