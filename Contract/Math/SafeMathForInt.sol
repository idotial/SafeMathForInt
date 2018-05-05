pragma solidity ^0.4.21;

library SafeMathForInt {
    
    uint256 public constant INT256_MAX = ~((uint256(1) << 255)); //57896044618658097711785492504343953926634992332820282019728792003956564819967
    
    function intToUintWithSignal(int input) internal pure returns(bool isPositive,uint amount){
        if(input < 0){
            isPositive = false;
            amount = uint(-input);
        } else {
            isPositive = true;
            amount = uint(input);
        }
    }
    
    function uintWithSignalToInt(uint input, bool isPositive) internal pure returns(int result) {
        require(input < INT256_MAX);
        if(!isPositive) {
            result = -int(input);
        } else {
            result = int(input);
        }
    }

    function mul(int256 a, int256 b) internal pure returns (int256) {
        if (a == 0 || b == 0) {
            return 0;
        }
        uint aValue;
        bool aIsPositive;
        uint bValue;
        bool bIsPositive;
        
        (aIsPositive, aValue) = intToUintWithSignal(a);
        (bIsPositive, bValue) = intToUintWithSignal(b);
        uint result = aValue * bValue;
        assert(result / aValue == bValue);
        return uintWithSignalToInt(result, aIsPositive==bIsPositive);
    }

    function div(int256 a, int256 b) internal pure returns (int256) {
        uint aValue;
        bool aIsPositive;
        uint bValue;
        bool bIsPositive;
        
        (aIsPositive, aValue) = intToUintWithSignal(a);
        (bIsPositive, bValue) = intToUintWithSignal(b);
        uint result = aValue / bValue;
        return uintWithSignalToInt(result, aIsPositive==bIsPositive);
    }

    function sub(int256 a, int256 b) internal pure returns (int256) {
        uint aValue;
        bool aIsPositive;
        uint bValue;
        bool bIsPositive;
        
        (aIsPositive, aValue) = intToUintWithSignal(a);
        (bIsPositive, bValue) = intToUintWithSignal(b);
        if(aIsPositive == bIsPositive) {
            return a - b;
        } else {
            // assert(result >= aValue); int won't bigger than half the maximent of uint256
            return uintWithSignalToInt(aValue + bValue, aIsPositive);
        }
    }

    function add(int256 a, int256 b) internal pure returns (int256 c) {
        uint aValue;
        bool aIsPositive;
        uint bValue;
        bool bIsPositive;
        
        (aIsPositive, aValue) = intToUintWithSignal(a);
        (bIsPositive, bValue) = intToUintWithSignal(b);
        if (aIsPositive==bIsPositive) {
            return uintWithSignalToInt(aValue + bValue, aIsPositive);
        } else {
            return a + b;
        }
        return c;
    }
}