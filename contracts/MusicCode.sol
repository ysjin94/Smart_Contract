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
        string _passcode;
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
    
   
    
    function buyCode(string memory _order_id, string memory passcode) public payable{
        require(codeCount > 0, "It is sold out, please contact to Seller");
        require(msg.value == 1 ether, "It is not correct value, please put right value");
        bytes memory passcodeChecker = bytes(passcode);
        require(passcodeChecker.length != 0, "please put the passcode");
        //check ID is exist or not.
        for(uint i = 0; i <NumberOfBuyer; i++){
            if( keccak256(abi.encodePacked(buyer[i]._id)) == keccak256(abi.encodePacked(_order_id)))
                require(false, "The ID is already exist, please enter other ID");
        }
        
        wallet.transfer(msg.value);
        
    
       buyer[NumberOfBuyer] = BuyInfo(_order_id,getCode(), passcode, block.timestamp);
       
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
    
    function getCodeCount() public view returns(uint256){
        return (codeCount);
    }
    
    function viewCode(string memory _order_id, string memory passcode) public view returns(string memory) {
        
        bytes memory passcodeChecker = bytes(passcode);
        require(passcodeChecker.length != 0, "please put the passcode");
        
        for(uint i = 0; i<NumberOfBuyer; i++ ){
            if( keccak256(abi.encodePacked(buyer[i]._id)) == keccak256(abi.encodePacked(_order_id)) && 
            keccak256(abi.encodePacked(buyer[i]._passcode)) == keccak256(abi.encodePacked(passcode)))
              return buyer[i]._code;
            
        }
        
    }
}
