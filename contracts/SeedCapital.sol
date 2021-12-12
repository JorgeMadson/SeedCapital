// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../.deps/npm/@openzeppelin/contracts/token/ERC20/ERC20.sol";

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

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        uint256 fee = (amount / 100) * 5; // Calculate 5% fee
        uint256 newAmount = amount - fee;

        _transfer(_msgSender(), admin, fee); // fee transfer
        _transfer(_msgSender(), recipient, newAmount); // recipient transfer

        return true;
    }
}
