// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ISnihur.sol";
import "./SPV.sol";
import "./CommitReveal.sol";

contract Snihur is ISnihur {
    using SPVLibrary for string;
    using SPVLibrary for int256;

    uint256 public SPVTotalReceived;

    CommitReveal private cr;

    address public owner;
    mapping(address => bool) public approvedUsers;
    mapping(address => uint256) public deposits;
    address[] public approvedUserList;
    uint256 public constant AMOUNT = 9 ether;
    uint256 public constant WITHDRAW_AMOUNT = 3;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        cr = new CommitReveal();
    }

    function SPVApproveAndDeposit() external payable {
        require(msg.sender != owner, "Owner should not be approved for his own contract");
        require(msg.value == AMOUNT, "Incorrect deposit amount");
        require(!approvedUsers[msg.sender], "Already approved");

        approvedUsers[msg.sender] = true;
        deposits[msg.sender] += msg.value;
        approvedUserList.push(msg.sender);
        
        emit Approved(msg.sender);
    }

    function SPVWithdraw() external onlyOwner {
        uint256 withdrawAmount = 0;

        for (uint256 i = 0; i < approvedUserList.length && withdrawAmount < WITHDRAW_AMOUNT; i++) {
            address user = approvedUserList[i];

            if (approvedUsers[user] && deposits[user] >= AMOUNT) {
                approvedUsers[user] = false;
                deposits[user] -= AMOUNT;

                payable(owner).transfer(AMOUNT);
                withdrawAmount++;
                emit Withdrawn(user, AMOUNT);
            }
        }
    }

    function SPVGetApprovedUsers() public view returns (address[] memory) {
        return approvedUserList;
    }
    
    function SPVParsePrice(string memory input) public pure returns (uint256) {
        return input.SPVParsePrice();
    }
    
    function SPVWeatherComment(int256 temp) public pure returns (string memory) {
        return temp.SPVGetWeatherComment();
    }


    function SPVCommit(string memory value) external {
        bytes32 commitHash = cr.createCommit(value);
        cr.commit(commitHash);
    }

    function SPVReveal(string memory value) external {
        cr.reveal(value);
    }
}