// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/finance/PaymentSplitter.sol";

/// Contract that will split the shares 50-50 to winner and owner.
contract Payments is PaymentSplitter{
    constructor(address[] memory _payees, uint256[] memory _shares) PaymentSplitter(_payees, _shares)  payable {}
}
