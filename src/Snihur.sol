// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./SPV.sol";

contract Snihur {
    using SPVLibrary for string;
    using SPVLibrary for int256;

    address[] private SPVSenders; // List of addresses that have sent ETH.
    uint256 public SPVTotalReceived; // Total amount of ETH received.

    address public owner;
    mapping(address => bool) public approvedUsers;
    mapping(address => uint256) public deposits;
    address[] public approvedUserList;
    uint256 public constant AMOUNT = 9 ether;

    event Approved(address indexed user);
    event Withdrawn(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function approveAndDeposit() external payable {
        require(msg.value == AMOUNT, "Incorrect deposit amount");
        require(!approvedUsers[msg.sender], "Already approved");

        approvedUsers[msg.sender] = true;
        deposits[msg.sender] += msg.value;
        approvedUserList.push(msg.sender);
        
        emit Approved(msg.sender);
    }

    function withdraw() external onlyOwner {
        for (uint256 i = 0; i < approvedUserList.length; i++) {
            address user = approvedUserList[i];

            if (approvedUsers[user] && deposits[user] >= AMOUNT) {
                approvedUsers[user] = false;
                deposits[user] -= AMOUNT;

                payable(owner).transfer(AMOUNT);
                emit Withdrawn(user, AMOUNT);
            }
        }
    }

    function getApprovedUsers() public view returns (address[] memory) {
        return approvedUserList;
    }
    
    receive() external payable {
        // require(msg.value == 9 ether, unicode"Invalid amount");
        SPVSenders.push(msg.sender);
    }

    fallback() external payable {
        revert("Fallback function: Invalid transaction");
    }
    
    function SPVGetTotalSenders() public view returns (uint256) {
        return SPVSenders.length;
    }
    
    function SPVIsFunded() public view returns (bool) {
        return SPVSenders.length >= 3 && SPVTotalReceived >= (9 ether * 3);
    }
    
    function SPVParsePrice(string memory input) public pure returns (uint256) {
        return input.SPVParsePrice();
    }
    
    function SPVWeatherComment(int256 temp) public pure returns (string memory) {
        return temp.SPVGetWeatherComment();
    }
}
