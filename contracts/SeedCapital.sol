// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../.deps/npm/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SeedCapital is ERC20 {
    //Initial token is 1.1 billions
    uint256 public initialSupply = 1100000000 * 10 ** decimals();
    constructor() ERC20("SeedCapital", "SCFT") {

        _mint(msg.sender, initialSupply);
    }
    
    function decimals() public view virtual override returns (uint8) {
      return 4;
    }

    //3% to the dev account
    // address admin = address(0x123);

    // function transfer(address _to, uint256 _amount) external returns (bool) {
    //     mapping(address => uint256)  balances;
    //     uint256 fee = (_amount / 100) * 3; // Calculate 3% fee

    //     balances[msg.sender] -= _amount; // subtract the full amount
    //     balances[admin] += fee; // add the fee to the admin balance
    //     balances[_to] += (_amount - fee); // add the remainder to the recipient balance
    // }
}
