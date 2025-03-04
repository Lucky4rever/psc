// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ISnihur.sol";
import "./Snihur.sol";

contract AnotherContract {
    ISnihur private _snihur = new Snihur();

    function approveAndDeposit() external payable {
        _snihur.SPVApproveAndDeposit();
    }

    function withdraw() external payable {
        _snihur.SPVWithdraw();
    }
}