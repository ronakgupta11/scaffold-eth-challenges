pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

// deploying "Vendor" (tx: 0x6dcace88d26b37e322bdbb93d34c976448f8a3fb9f11ba04c975e745a582be93)...: deployed at 0xd8e75c4Df07E3afE65c78c25b85a0C8C7299083b

// domain: uppity-minister.surge.sh

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;
  uint public constant tokensPerEth = 100;


  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable{
    yourToken.transfer(msg.sender,msg.value*tokensPerEth);
    emit BuyTokens(msg.sender,msg.value,msg.value*tokensPerEth);

  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() onlyOwner public payable{
    (bool sent,) = msg.sender.call{value :address(this).balance}("");
    require(sent,"failed to send ether");

  }

function sellTokens(uint _amount) public{
  // require(yourToken.approve(),"you should approve first");
  yourToken.transferFrom(msg.sender,address(this),_amount);
  (bool sent,) = msg.sender.call{value : (_amount/tokensPerEth)}("");
  require(sent,"failed");
  

}
  // ToDo: create a sellTokens(uint256 _amount) function:

}
