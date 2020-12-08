# Smart_Contract
## Group member:
-   Sunjin Y: sunjin.yoon07@myhunter.cuny.edu
## Purpose of Contract:

Music streamming code smart contract. It is like kind of a vending machine for music. Owner only can add Code for the streaming. The buyers can buy the code via the smart contract. If the buyer use the code on music website or application, they can lisen to music for a day without any interrupt such as Ad, infinite skip songs, and more. Only the seller can add the codes, and buyers can know that there are not no coupon if the code is sold out. Of course, it is Non-refundeable, because if the buyer get the code, seller cannot know the buyer use or not. 
## interface
Function addCode(string memory _code) => the onwer of contract can add code on the contract. Only onwer can call the function.

Function buyCode(string memory _order_id, string memory passcode) => the buyer can buy the code. buyer enter their id, and passcode

Function close() => destroy the contract. the contract does not work after calling the function.

Function clear() => clear Buyers, the day buyer bought after 30 days.

Function getCode() => it is for show the logs(events)

Function getCodeCount() => it shows that how many code is left.

Function viewCode(string memory _order_id, string memory passcode) => view the codes, the buyer should enter their id and passcode.

## how to run 
copy the whole MusicCode.sol to 
* website:http://remix.ethereum.org/

or use `truffle`
* type `./node_modules/.bin/truffle test`

### [Styling of Interface](https://solidity.readthedocs.io/en/v0.5.13/style-guide.html)
