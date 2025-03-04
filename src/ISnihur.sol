    // SPDX-License-Identifier: GPL-3.0

    pragma solidity >=0.7.0 <0.9.0;

    import "./SPV.sol";

    interface ISnihur {
        event Approved(address indexed user);
        event Withdrawn(address indexed user, uint256 amount);

        function SPVTotalReceived() external view returns (uint256);
        function owner() external view returns (address);
        function approvedUsers(address user) external view returns (bool);
        function deposits(address user) external view returns (uint256);
        function approvedUserList(uint256 index) external view returns (address);
        function AMOUNT() external pure returns (uint256);

        function approveAndDeposit() external payable;
        function withdraw() external;
        function getApprovedUsers() external view returns (address[] memory);
        function SPVGetTotalSenders() external view returns (uint256);
        function SPVIsFunded() external view returns (bool);
        function SPVParsePrice(string memory input) external pure returns (uint256);
        function SPVWeatherComment(int256 temp) external pure returns (string memory);

        receive() external payable;
        fallback() external payable;
    }
