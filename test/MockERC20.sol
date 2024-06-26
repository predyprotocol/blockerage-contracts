// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../lib/permit2/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

/**
 * @notice Mock of ERC20 contract
 */
contract MockERC20 is ERC20 {
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }
}
