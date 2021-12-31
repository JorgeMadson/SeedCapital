// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./lib.sol";

contract SeedCapital is ERC20 {

    uint256 public timelock;
    address public devFund = address(0x13b1F137862C42F4B97D976d9313550a5Cb2e8C8);
    address public foundersFund = address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);

    constructor() ERC20("SeedCapital", "SCFT") {
        // Initial founders fund lockup period is 2 years
        uint256 _timelock = 104 weeks;
        timelock = block.timestamp + _timelock;
        // Token supply is 1.1 billion
        uint256 initialSupply = 1100000000 * 10**decimals();
        _mint(msg.sender, initialSupply);
    }

    function decimals() public view virtual override returns (uint8) {
        return 4; // why 4?
    }

    function _transfer(address sender, address recipient, uint256 amount) internal virtual override {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(sender != foundersFund || timelock <= block.timestamp, "founders fund is timelocked");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[sender] = senderBalance - amount;
        }

        uint256 fee = (amount / 100) * 5; // Calculate 5% fee
        uint256 newAmount = amount - fee;

        _balances[devFund] += fee;
        _balances[recipient] += newAmount;

        emit Transfer(sender, recipient, amount);

        _afterTokenTransfer(sender, recipient, amount);
    }
}
