// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../.deps/npm/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SeedCapital is ERC20 {
    //Initial token is 1.1 bitlions
    uint256 public initialSupply = 11000000000000; //+ 4 zeros por conta dos decimais!
    constructor() ERC20("SeedCapital", "SCFT") {

        _mint(msg.sender, initialSupply);
    }
    
    function decimals() public view virtual override returns (uint8) {
      return 4;
    }
}