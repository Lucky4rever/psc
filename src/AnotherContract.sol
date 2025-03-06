// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ISnihur.sol";
import "./Snihur.sol";

contract AnotherContract {
    ISnihur private _snihur;

    constructor() {
        _snihur = new Snihur();
    }

    function approveAndDeposit() external payable {
        _snihur.SPVApproveAndDeposit();
    }

    function withdraw() external payable {
        _snihur.SPVWithdraw();
    }

    function parsePrice(string memory input) public view returns (uint256) {
        return _snihur.SPVParsePrice(input);
    }

    function weatherComment(int256 temperature) public view returns (string memory) {
        return _snihur.SPVWeatherComment(temperature);
    }
}