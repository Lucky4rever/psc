// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract CommitReveal {
    mapping (address => bytes32) public commits;

    event Committed(address indexed user, bytes32 commitHash);
    event Revealed(address indexed user, string revealedValue);

    function commit(bytes32 _hash) public {
        require(commits[msg.sender] == bytes32(0), "Already committed");
        commits[msg.sender] = _hash;

        emit Committed(msg.sender, _hash);
    }

    function reveal(string calldata value) public {
        require(commits[msg.sender] != bytes32(0), "No commit found");

        bytes32 expectedHash = createCommit(value);
        require(expectedHash == commits[msg.sender], "Invalid reveal");

        delete commits[msg.sender];

        emit Revealed(msg.sender, value);
    }

    function createCommit(string memory value) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(value));
    }
}
