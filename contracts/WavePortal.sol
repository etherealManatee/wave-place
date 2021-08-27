//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves; //solidity will initialize totalWaves to zero
    uint seed;

    event NewWave(address indexed from, uint timestamp, string message);

    //a struct is a custum data type where we can customise what we want to hold inside it
    struct Wave {
        string message; //the message the user sent
        address waver;  //the address of the user who waved
        uint timestamp; //timestamp when the user waved
    }

    //declared a variable waves that lets us store an array of structs
    //holds all the waves anyone ever sends to me
    Wave[] waves;


    mapping(address => uint) public lastWaveAt;

    constructor() payable {
        console.log("we have been constructed!, WavePortal.sol contract WavePortal");
    }

    //this is a state changing function because it will change the variable and save it on to the blockchain
    function wave(string memory _message) public {
        //to prevent spamming
        require(lastWaveAt[msg.sender] + 5 minutes < block.timestamp, "You gotta wait 30 seconds!!");

        totalWaves += 1;
        console.log("%s waved with message: %s", msg.sender, _message); 
        waves.push(Wave(_message, msg.sender, block.timestamp));

        // Generate random #
        uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        
        //set the seed
        seed = randomNumber;
        console.log("%s random num", randomNumber);
        //give user 50% chance of winning
        if (randomNumber < 50){
            //win prize
            console.log("%s -- won the prize!", msg.sender);
            //send money
            uint prizeAmount = 0.0001 ether;

            //line below is to check if there is money
            require(prizeAmount <= address(this).balance, "Contract doesn't have enough money, we poor");
            //if we pass the line above, it means we have money!
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            //check if all is well.
            require(success, "Failed to withdraw money from contract");
        }

        //emit the event
        emit NewWave(msg.sender, block.timestamp, _message);
        

    }

    //view means it's a readonly
    //
    function getAllWaves() view public returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() view public returns (uint) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}