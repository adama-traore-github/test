// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UserToken is ERC20 {
    address public owner;
    uint8 private _tokenDecimals;

    struct TokenInfo {
        string name;
        string symbol;
        address tokenAddress;
    }
    
    TokenInfo[] public tokens;

    event TokenCreated(address indexed creator, string name, string symbol, uint256 supply);

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply,
        uint8 decimals_
    ) ERC20(_name, _symbol) {
        owner = msg.sender;
        _tokenDecimals = decimals_;
        uint256 initialSupplyWithDecimals = _initialSupply * (10 ** uint256(decimals_));
        _mint(msg.sender, initialSupplyWithDecimals);

        tokens.push(TokenInfo(_name, _symbol, address(this)));
        emit TokenCreated(msg.sender, _name, _symbol, _initialSupply);
    }

    // Fonction pour détruire des tokens en unités d'utilisateur (en décimales)
    function burn(uint256 amount) external {
        uint256 amountWithDecimals = amount * (10 ** uint256(decimals()));
        require(balanceOf(msg.sender) >= amountWithDecimals, "Solde insuffisant pour cette operation");
        _burn(msg.sender, amountWithDecimals);
    }

    // Fonction pour obtenir le solde en unités décimales
    function getBalanceInDecimals(address account) external view returns (uint256) {
        uint256 balance = balanceOf(account);
        return balance / (10 ** uint256(decimals()));
    }

    // Fonction pour obtenir le solde en format natif (wei)
    function getBalanceInWei(address account) external view returns (uint256) {
        return balanceOf(account);
    }

    // Obtenir les informations des tokens
    function getTokens() external view returns (TokenInfo[] memory) {
        return tokens;
    }

    // Définir les décimales du token pour la conversion
    function decimals() public view virtual override returns (uint8) {
        return _tokenDecimals;
    }
}
