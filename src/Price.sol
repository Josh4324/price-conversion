// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/chainlink-brownie-contracts/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConverter {
    AggregatorV3Interface internal priceFeedBTCETH;
    AggregatorV3Interface internal priceFeedBTCUSD;
    AggregatorV3Interface internal priceFeedETHUSD;

    constructor(address _btcEthpriceFeedAddress, address _btcUsdpriceFeedAddress, address _ethUsdpriceFeedAddress) {
        priceFeedBTCETH = AggregatorV3Interface(_btcEthpriceFeedAddress);
        priceFeedBTCUSD = AggregatorV3Interface(_btcUsdpriceFeedAddress);
        priceFeedETHUSD = AggregatorV3Interface(_ethUsdpriceFeedAddress);
    }

    function getLatestPriceBTCETH() public view returns (uint256) {
        (
            /* uint80 roundID */
            ,
            int256 answer,
            /*uint startedAt*/
            ,
            /*uint timeStamp*/
            ,
            /*uint80 answeredInRound*/
        ) = priceFeedBTCETH.latestRoundData();
        return uint256(answer);
    }

    function getLatestPriceBTCUSD() public view returns (uint256) {
        (
            /* uint80 roundID */
            ,
            int256 answer,
            /*uint startedAt*/
            ,
            /*uint timeStamp*/
            ,
            /*uint80 answeredInRound*/
        ) = priceFeedBTCUSD.latestRoundData();
        return uint256(answer * 10 ** 10);
    }

    function getLatestPriceETHUSD() public view returns (uint256) {
        (
            /* uint80 roundID */
            ,
            int256 answer,
            /*uint startedAt*/
            ,
            /*uint timeStamp*/
            ,
            /*uint80 answeredInRound*/
        ) = priceFeedETHUSD.latestRoundData();
        return uint256(answer * 10 ** 10);
    }

    // Convert BTC to ETH
    function convertBTCtoETH(uint256 btcAmount) external view returns (uint256) {
        // Get the latest price of BTC TO ETH
        uint256 ethPriceInBTC = getLatestPriceBTCETH();

        uint256 result = ethPriceInBTC * btcAmount;

        return result;
    }

    // Convert BTC to USD
    function convertBTCtoUSD(uint256 btcAmount) external view returns (uint256) {
        // Get the latest price of BTC TO USD
        uint256 usdPriceInBTC = getLatestPriceBTCUSD();

        uint256 result = usdPriceInBTC * btcAmount;

        return result;
    }

    // Convert ETH to USD
    function convertETHtoUSD(uint256 ethAmount) external view returns (uint256) {
        // Get the latest price of BTC TO USD
        uint256 usdPriceInETH = getLatestPriceETHUSD();

        uint256 result = usdPriceInETH * ethAmount;

        return result;
    }
}
