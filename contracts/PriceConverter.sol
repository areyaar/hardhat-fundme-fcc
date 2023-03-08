//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;


import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter{

    function getPrice() internal view returns(uint256){
        AggregatorV3Interface priceFeed= AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (/* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        
        return uint256(price*1e10); // iski math samjho tum -> it is returning the price in wei
        
    }


    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        uint USD = (ethAmount*ethPrice);
        return USD; // ye bhi 18 decimal me hai
    }
}
