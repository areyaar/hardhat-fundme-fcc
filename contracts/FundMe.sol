//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol"; 

contract FundMe{
    
    using PriceConverter for uint256;
    
    uint256 constant MINIMUM_USD = 5* 1e18;
    mapping(address=>uint256) public amount;
    address[] public funders;
    
    address public immutable i_owner;

    modifier onlyOwner {
        require(msg.sender == i_owner, "Only the owner can call this function.");
        _;
    } 

    constructor(){
        i_owner = msg.sender;
    }
    
    function fund() public payable {
        uint256 dollarRecieved = msg.value.getConversionRate(); 
        require(dollarRecieved>=MINIMUM_USD, "Not Enough!");
        funders.push(msg.sender);
        amount[msg.sender]+=msg.value;
    }


    function withdraw() public onlyOwner{
        for(uint i=0;i<funders.length; i++){
            address funder = funders[i];
            amount[funder]=0;
        }
        
        funders = new address[](0); 
 
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "Call Failed!");
        
    }  
    
}

