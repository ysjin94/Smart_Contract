pragma solidity 0.5.1;

contract Music{
  
  address payable wallet; 
  
  // initial code is empty.
  uint256 public codeCount = 0
  
  constructor(address payable _wallet) public{
    wallet = _wallet;
   }
    address owner;
  
  //set modifier  
    modifier onlyOwner(){
      require(msg.sender == owner, "Only the contract owner can call this function");
      _;
    }
  
    constructor() public {
      owner = msg.sender;
    }
    
    struct Code{
      uint _code;
    }
    
    
    function addCode(uint _code) public onlyOwner{
      //increase total number of the codes
      incrememtCodeCount();
      Code[codecount] = Code(_code);
    }
    
    function incrementCodeCount() internal{
      codeCount += 1;
    }
    
    function buyCode() public payable{
      // need to add show the music streaming code.
      // and delete the code from the list.
      // add discount, if the user buy the code several times, he get discount 50%
      // after that the stack will be reset.
      wallet.transfer(msg.value);
    }
}
