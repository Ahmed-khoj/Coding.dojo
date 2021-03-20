//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.8.1;

contract ChangeContractStatus {
address private Owner;
bool private flag;

modifier signedByOwner (){
     require(msg.sender == Owner, "Note::only the owner of the contract");
        _;
    }
 modifier stopFunctions () {
         require(flag, "SC is not working");
        _;
    }

function setFlag (bool _flag) public signedByOwner {
        require(_flag != flag, "the flag has to be different");
        flag = _flag;
    }
  
function isFlagStatus() public view returns(bool) {
        return flag;
    }
}