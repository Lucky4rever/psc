    // SPDX-License-Identifier: GPL-3.0

    pragma solidity >=0.7.0 <0.9.0;

    import "./SPV.sol";

    interface ISnihur {
        event Approved(address indexed user);
        event Withdrawn(address indexed user, uint256 amount);

        function owner() external view returns (address);
        function approvedUsers(address user) external view returns (bool);
        function deposits(address user) external view returns (uint256);
        function approvedUserList(uint256 index) external view returns (address);
        function AMOUNT() external pure returns (uint256);
        function WITHDRAW_AMOUNT() external pure returns (uint256);

        function SPVApproveAndDeposit() external payable;
        function SPVWithdraw() external;
        function SPVGetApprovedUsers() external view returns (address[] memory);
        function SPVParsePrice(string memory input) external pure returns (uint256);
        function SPVWeatherComment(int256 temp) external pure returns (string memory);
        
        function SPVCommit(string memory value) external;
        function SPVReveal(string memory value) external;
    }
