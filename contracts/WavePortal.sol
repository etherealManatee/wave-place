//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves; //solidity will initialize totalWaves to zero


    struct Wave {
        string message;
        address waver;
        uint timestamp;
    }

    Wave[] waves;

    constructor() payable {
        console.log("anything, you are hardworking");
    }

    //this is a state changing function because it will change the variable and save it on to the blockchain
    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved", msg.sender); 
        console.log("Got message: %s", _message);
        waves.push(Wave(_message, msg.sender, block.timestamp));
        
        //send money
        uint prizeAmount = 0.0001 ether;

        //line below is to check if there is money
        require(prizeAmount <= address(this).balance, "Contract doesn't have money AHHH");
        //if we pass the line above, it means we have money!
        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        
        //check if all is well.
        require(success, "Failed to send money");
    
    }

    //view means it's a readonly
    function getAllWaves() view public returns(Wave[] memory) {
        return waves;
    }

    function getTotalWaves() view public returns (uint) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}