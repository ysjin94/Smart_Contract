pragma solidity 0.5.16;


contract Music {
    
    uint256 public codeCount = 0;
    mapping(uint256 => Code) public code;
    
    address payable wallet;
    
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
      uint manufacture_date;
    }
    

    event InsertCode(
        string _input,
        uint256 _count
        );
    
    event OrderInfo(
        string  order_id,
        address _buyer,
        uint _cost,
        string _code,
        uint order_date
    );
    
    function close() public onlyOwner{
        
        selfdestruct(wallet);
        
    }
    
    function addCode(string memory _code) public onlyOwner{
      //increase total number of the codes
      incrementCodeCount();
      code[codeCount] = Code(_code, block.timestamp);
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
        require(codeCount > 0, "It is sold out, please contact to Seller");
        require(msg.value == 1, "It is not correct value, please put right value");

        wallet.transfer(msg.value);
        
        //show the logs
        getCode();
        emit OrderInfo(_order_id, msg.sender, 1, getCode(), block.timestamp); 
        //remove the code after selling
        delete code[codeCount];
        decrementCodeCount();
    }
    
    function getCode() internal returns(string memory bought_code) {
        bought_code = code[codeCount]._code;
    }


}
