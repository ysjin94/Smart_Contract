pragma solidity 0.5.1;

Contract Music{
  // owner can only modify the contract
  address owner;
    
    modifier onlyOwner(){
      require(msg.sender == owner);
      _;
    }
}
