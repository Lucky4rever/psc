// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title SPVLibrary
 * @dev A library providing utility functions for parsing prices and generating weather comments.
 */
library SPVLibrary {
    /**
     * @dev Parses a numeric price from a string (e.g., "ETH=3200$").
     * @param input The input string containing the price.
     * @return The extracted numeric price.
     */
    function SPVParsePrice(string memory input) internal pure returns (uint256) {
        bytes memory strBytes = bytes(input);
        
        uint256 number = 0;
        bool isParsing = false;

        for (uint256 i = 0; i < strBytes.length; i++) {
            if (strBytes[i] >= "0" && strBytes[i] <= "9") {
                isParsing = true;
                number = number * 10 + (uint8(strBytes[i]) - 48);
            } else if (isParsing) {
                break;
            }
        }

        return number;
    }

    /**
     * @dev Returns a weather comment based on the provided temperature.
     * @param temp The temperature in Celsius.
     * @return A weather comment with the provided temperature.
     */
    function SPVGetWeatherComment(int256 temp) internal pure returns (string memory) {
        if (temp < 0) return string(abi.encodePacked(unicode"cold: ", intToString(temp), " C"));
        if (temp <= 20) return string(abi.encodePacked(unicode"cool: ", intToString(temp), " C"));
        if (temp <= 30) return string(abi.encodePacked(unicode"warm: ", intToString(temp), " C"));
        return string(abi.encodePacked(unicode"hot: ", intToString(temp), " C"));
    }

    /**
     * @dev Converts an integer to a string.
     * @param value The integer to convert.
     * @return The string representation of the integer.
     */
    function intToString(int256 value) internal pure returns (string memory) {
        if (value == 0) return "0";
        bool negative = value < 0;
        uint256 temp = negative ? uint256(-value) : uint256(value);
        bytes memory buffer;
        
        while (temp != 0) {
            buffer = abi.encodePacked(uint8(temp % 10 + 48), buffer);
            temp /= 10;
        }
        
        return negative ? string(abi.encodePacked("-", buffer)) : string(buffer);
    }
}