//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SKYUSD is ERC20 {
    constructor(uint amount) ERC20('SKYFI STABLECOIN', 'SKYUSD') {
        _mint(msg.sender, amount);
    }

    function mint(address _to, uint256 _amount) public returns (bool) {
        _mint(_to, _amount);
        return true;
    }
}
