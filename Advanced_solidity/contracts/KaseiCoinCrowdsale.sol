pragma solidity ^0.5.5;

import "./KaseiCoin.sol";//we created a mintable token

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Have the KaseiCoinCrowdsale contract inherit the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale{ // we leveradge the token through a crowdsale token
    


   constructor(
        uint rate,
        address payable wallet,//payable wallet that receives the fund
        KaseiCoin token //token that comes in form of address
    )  Crowdsale(rate, wallet, token) 
    public
    {   }

}


contract KaseiCoinCrowdsaleDeployer { //deployer
    // Create an `address public` variable called `kasei_token_address`.
    address public kasei_token_address;
    // Create an `address public` variable called `kasei_crowdsale_address`.
    address public kasei_crowdsale_address;

    // Add the constructor.
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
    ) public {
        // Create a new instance of the KaseiCoin contract.
        KaseiCoin KaseiCoinToken = new KaseiCoin(name, symbol,0);
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        kasei_token_address = address(KaseiCoinToken);

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        KaseiCoinCrowdsale KaseiCoinCrowdSale_token = new KaseiCoinCrowdsale(1,wallet, KaseiCoinToken);
            
        // Aassign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        kasei_crowdsale_address = address(KaseiCoinCrowdSale_token);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        KaseiCoinToken.addMinter(kasei_crowdsale_address);
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        KaseiCoinToken.renounceMinter();
    }
}
