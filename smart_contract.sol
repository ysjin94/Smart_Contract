pragma solidity 0.5.1;

contract owner{
    address payable owner_wallet;
    
     constructor() public{
        owner_wallet = msg.sender;
    }
    
    modifier onlyOwner{
        require(msg.sender == owner_wallet, "Only owner can modify the function");
        _;
    }
    
}

contract deconstrcut is owner{
    function destory() public onlyOwner {
        selfdestruct(owner_wallet);
    }
}

contract Music is deconstrcut{
    
    uint256 public codeCount = 0;
    mapping(uint256 => Code) public code;

    constructor(address payable _wallet) public{
        owner_wallet = _wallet;
    }
    
    struct Code{
      uint _code;
      string _id;
      uint _cost;
      uint manufacture_date;
     
    }
    
    event OrderInfo(
        string order_id,
        address _buyer,
        uint _code,
        uint _cost,
        uint manufacture_date
    );
     
    function addCode(uint _code, string memory order_id, uint _cost ) public onlyOwner{
      //increase total number of the codes
      incrementCodeCount();
      code[codeCount] = Code(_code, order_id, _cost, block.timestamp);
    }
    
    
    function incrementCodeCount() internal{
      codeCount += 1;
    }
    
    function buyCode() public payable{
      // need to add show the music streaming code.
      // and delete the code from the list.
      // add discount, if the user buy the code several times, he get discount 50%
      // after that the stack will be reset.
      owner_wallet.transfer(msg.value);
      //emit OrderInfo( ,code[codeCount],msg.value, block.timestamp);
        
    }
 
}
