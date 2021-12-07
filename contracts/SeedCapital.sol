// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../.deps/npm/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SeedCapital is ERC20 {

    //Initial token is 1.1 billions
    uint256 public initialSupply = 1100000000 * 10**decimals();
    mapping(address => uint256) private balances;

    constructor() ERC20("SeedCapital", "SCFT") {
        _mint(msg.sender, initialSupply);
    }

    function decimals() public view virtual override returns (uint8) {
        return 4;
    }

    // 5% to the dev account
    address admin = address(0x123);

    function transfer(address _to, uint256 _amount)
        public
        override
        returns (bool)
    {
        uint256 fee = (_amount / 100) * 5; // Calculate 5% fee

        balances[msg.sender] -= _amount; // subtract the full amount
        if (balances[msg.sender] > _amount + fee) {
            transactionFee(fee);
            balances[_to] += (_amount); // add the remainder to the recipient balance
            return true;
        } else return false;
    }

    function transactionFee(uint256 _fee_amount) internal returns (bool) {
        //send to admin wallet
        balances[msg.sender] -= _fee_amount; // subtract the fee
        balances[admin] += _fee_amount; // add the fee to the admin balance
        return true;
    }
}
