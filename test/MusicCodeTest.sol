pragma solidity 0.5.16;

import "truffle/Assert.sol";
import "../contracts/MusicCode.sol";

contract MusicCodeTest{
	uint public initialBalance = 1 ether;
		
	function testSettingAnOwnerDuringCreation() public {
		Music music = new Music();
	}
	
	function testAddCode() public {
		Music music = new Music();
                music.addCode("ThisIsTest1");
	}

	function testBuyCode() public {
		Music music = new Music();
		music.addCode("ThisIsTest2");
		music.buyCode("User_ID", "passcode");
	}
	
	function testBuyCode_SoldOut() public {
		Music music = new Music();
		music.buyCode("User_ID", "passcode");
	}

	function testBuyCode_WrongValue() public{
		Music music = new Music();
		music.addCode("ThisIsTest3");
		music.buyCode("User_ID", "passcode");
	}
	
	function TestClose() public{
		Music music = new Music();
		music.close();
	}
}

