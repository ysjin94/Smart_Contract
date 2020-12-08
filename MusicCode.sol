pragma solidity 0.5.16;


contract Music {
    
    uint256 codeCount = 0;
    uint256 NumberOfBuyer =0;
    mapping(uint256 => Code) code;
    mapping(uint256 => BuyInfo) buyer;
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
    
    struct BuyInfo{
        string _id;
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
    
    event test(
        string _order_id,
        string _cd,
        uint date
        
    );
    
    function buyCode(string memory _order_id) public payable{
        require(codeCount > 0, "It is sold out, please contact to Seller");
        require(msg.value == 1 ether, "It is not correct value, please put right value");
        
        //check ID is exist or not.
        for(uint i = 0; i <NumberOfBuyer; i++){
            if( keccak256(abi.encodePacked(buyer[i]._id)) == keccak256(abi.encodePacked(_order_id)))
                require(false, "The ID is already exist, please enter other ID");
        }
        

        wallet.transfer(msg.value);
        
       // add buyer
       buyer[NumberOfBuyer] = BuyInfo(_order_id,getCode(),block.timestamp);
       NumberOfBuyer++;
       
       //show the logs
        emit OrderInfo(_order_id, msg.sender, 1, getCode(), block.timestamp); 
        //remove the code after selling
        delete code[codeCount];
        decrementCodeCount();
    }
    
    function getCode() internal returns(string memory bought_code) {
        bought_code = code[codeCount]._code;
    }
    
    // view the how many left the codes
    function getCodeCount() public view returns(uint256){
        return (codeCount);
    }
    
    //buyer get the code
    function viewCode(string memory _order_id) public view returns(string memory) {
        for(uint i = 0; i<NumberOfBuyer; i++ ){
            if( keccak256(abi.encodePacked(buyer[i]._id)) == keccak256(abi.encodePacked(_order_id)))
              return buyer[i]._code;
            
        }
        
    }
}
