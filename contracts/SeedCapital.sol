// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "../.deps/npm/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./ERC20.sol";

contract SeedCapital is ERC20 {

    //Initial token is 1.1 billions
    uint256 public initialSupply = 1100000000 * 10**decimals();
    address public admin = address(0x123);

    constructor() ERC20("SeedCapital", "SCFT") {
        _mint(msg.sender, initialSupply);
    }

    function decimals() public view virtual override returns (uint8) {
        return 4; // why 4?
    }

    function _transfer(address sender, address recipient, uint256 amount) internal virtual override {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[sender] = senderBalance - amount;
        }

        uint256 fee = (amount / 100) * 5; // Calculate 5% fee
        uint256 newAmount = amount - fee;

        _balances[admin] += fee;
        _balances[recipient] += newAmount;

        emit Transfer(sender, recipient, amount);

        _afterTokenTransfer(sender, recipient, amount);
    }
}
