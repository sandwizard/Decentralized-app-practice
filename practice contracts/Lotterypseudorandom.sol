//SPDX-License-Identifier: MIT
 pragma solidity ^0.8.13;

 contract Lottery{
     address public owner;
     address payable[] public players;
     uint public lotteryId ;
     mapping (uint => address) public lotterywinners;

     constructor(){
         owner = msg.sender;
     }

     function enterLottery() public payable{
         require(msg.value > 0.1 ether);
         players.push(payable(msg.sender));
     }

     function getRandom() public view returns (uint){
         return (uint(keccak256(abi.encodePacked(owner,block.timestamp))));

     }
    
     function getPlayers() public view returns(address payable[] memory) {
         return players;

     }
     function pickWinner() public onlyOwner {
         require(players.length != 0,"no players in lottery" );
         require(address(this).balance != 0 ether,"no monery in pot");
         uint index = getRandom() % players.length;
         players[index].transfer(address(this).balance);
         lotterywinners[lotteryId] = players[index];
         lotteryId ++;

         
         // reset state of players;
         players = new address payable[](0);
         
     }

     function potbalaance()public view returns (uint){
         return (address(this).balance);
     }

     modifier onlyOwner(){
         require(msg.sender == owner,"not Owner");
         _;
     }
 }