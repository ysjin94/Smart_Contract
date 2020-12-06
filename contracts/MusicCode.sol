pragma solidity 0.5.16;


contract Music {

    uint256 public codeCount = 0;
    mapping(uint256 => Code) public code;

    address payable public wallet;
    
    constructor() public{
       wallet = msg.sender;
    }
    
    //only owner can add more codes
    modifier onlyOwner{
        require(msg.sender == wallet, "Only owner can use the function");
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
        string  order_id,
        address _buyer,
        uint _cost,
        uint manufacture_date
    );
    
    //destory the contract
    function close() public onlyOwner{
        
        selfdestruct(wallet);
        
    }
    
    function addCode(string memory _code) public onlyOwner{
      //increase total number of the codes
      incrementCodeCount();
      code[codeCount] = Code(_code);
      //show the logs
      emit InsertCode(_code, codeCount);
      
    }
    
    //increase total code count
    function incrementCodeCount() internal{
      codeCount += 1;
    }

    //decrease total code count
    function decrementCodeCount() internal{
      codeCount -= 1;
    }
    
    
    function buyCode(string memory _order_id) public payable{
        //check the code is sold out or not
        require(codeCount > 0, "It is sold out, please contact to Seller");

        //chekc the buyer put right values
        require(msg.value == 1, "It is not correct value, please put right value");

        //send it to seller
        wallet.transfer(msg.value);
        
        //show the OrderInformation (logs)
        emit OrderInfo(_order_id, msg.sender, 1, block.timestamp); 
        
        //remove the code after selling
        delete code[codeCount];
        decrementCodeCount();
    }
    


}
