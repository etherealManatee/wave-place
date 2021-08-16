pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves; //solidity will initialize totalWaves to zero

    constructor() {
        console.log("farm everyday, you are hardworking");
    }

    //this is a state changing function because it will change the variable and save it on to the blockchain
    function wave() public {
        totalWaves += 1;
        console.log("%s waved", msg.sender);
    }

    function getTotalWaves() view public returns (uint) {
        return totalWaves;
    }
}