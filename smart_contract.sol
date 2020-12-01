pragma solidity 0.5.1;

Contract Music{
  // initial code is empty.
  uint256 public codeCount = 0
  
  // owner can only modify the contract
  address owner;
    
    modifier onlyOwner(){
      require(msg.sender == owner);
      _;
    }
    
    struct Code{
      uint _code;
    }
    
    constructor() public {
      owner = msg.sender;
    }
    
    function addCode(uint _code) public onlyOwner{
      //increase total number of the codes
      incrememtCodeCount();
      Code[codecount] = Code(_code);
    }
    
    function incrementCodeCount() internal{
      codeCount += 1;
      
}
