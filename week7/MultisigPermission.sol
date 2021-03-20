//SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.8.1;

contract Permissions {
    address private contractOwner;
    uint M = 3;
    address [] private authenticators ;
    //address [] private n_Authenticators;

    mapping (address => bool) private isAdmin;
    mapping(uint => mapping(address => bool)) public isConfirmed;
    
    
    constructor(address[] memory _authenticators , uint _M) public {
        require(_authenticators.length > 0, "owners required");
        require(
            _M> 0 && _M <= _authenticators.length,
            "invalid number of required confirmations"
        );
        contractOwner = msg.sender;
        isAdmin[msg.sender] = false;
        M = _M;
    }
 
    //---  the function modifiers ---- ///
    
    modifier onlyContractOwner() {
        require(msg.sender == contractOwner, "Not contract owner");
        _;
    }
    
    modifier notNull(address _address) {
    require(_address != address(0));
        _;
    }
    
    
    modifier AuthenticatorExist(address _address) {
        require(isAdmin[_address] == false, "already added!");
        _;
  }

    // -- helper functions
    function getAuths() public view returns (address[] memory)
    {
        return authenticators;
    }
    
    function addAuths(address _address) public onlyContractOwner() AuthenticatorExist(_address) notNull(_address) {
         isAdmin[_address] = true;
         M++;
        
    }
    
    function Authrize() public  returns (uint _x) {
        require(isAdmin[msg.sender] == true, "no you can't");
        authenticators.push(msg.sender);
        return (authenticators.length);
    }
    

}