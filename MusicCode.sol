pragma solidity 0.5.1;


contract Music {
    uint256 public codeCount = 0;
    mapping(uint256 => Code) public code;

    address payable wallet;
    
    constructor(address payable _wallet) public{
       wallet = _wallet;
    }
    
    //only owner can add more codes
    modifier onlyOwner{
        require(msg.sender == wallet, "Only owner can modify the function");
        _;
    }
    
  
    struct Code{
      string _code;
    }
    
    event InsertCode(
        string _input,
        uint256 _count
        );
    
    event OrderInfo(
        string indexed order_id,
        address indexed _buyer,
        uint _cost,
        uint manufacture_date
    );

    function addCode(string memory _code) public onlyOwner{
      //increase total number of the codes
      incrementCodeCount();
      code[codeCount] = Code(_code);
      //show the logs
      emit InsertCode(_code, codeCount);
      
    }
    
    
    function incrementCodeCount() internal{
      codeCount += 1;
    }
    
    function decrementCodeCount() internal{
      codeCount -= 1;
    }
    
    function buyCode(string memory _order_id) public payable{
        
        // Check the code is left or not 
        require(codeCount > 0, "It is sold out, please contact to Seller");
        
        // Check the buyer put right value
        require(msg.value == 1, "It is not correct value, please put right value");
        
        wallet.transfer(msg.value);
        
        //show the logs
        emit OrderInfo(_order_id, msg.sender, 1, block.timestamp); //, code[codeCount], msg.value, block.timestamp);
        
        //remove the code after selling
        delete code[codeCount];
        decrementCodeCount();
      
      
        
    }
}
