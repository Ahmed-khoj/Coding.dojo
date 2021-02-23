//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;

/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
contract TechInsurance {
    
    /** 
     * Define two structs
     * 
     * 
     */
    struct Product {
        uint productId;
        string productName;
        uint price;
        bool offered;
    }
     
    struct Client {
        bool isValid;
        uint time;
    }
    
    
    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    
    uint productCounter;
    
    address payable insOwner;
    constructor(address payable _insOwner) public  {
        insOwner = _insOwner;
        
    }
    
    address public Owner;
    modifier OnlyOwner (){
        require( Owner == msg.sender, "you are not the owner");
        _;
    }
    
 
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
         
         
         Product memory newProduct = Product(_productId, _productName, _price, true);
         insOwner = msg.sender;
         productIndex[productCounter++] = newProduct;
         
        
    }
    
    
    function changeFalse(uint _productIndex) public {
        require (productIndex[_productIndex].offered = false, "the product is not covered");
        

    }
    
    function changeTrue(uint _productIndex) public {
         require (productIndex[_productIndex].offered = true, "the product is covered");

    }
    
    function changePrice(uint _productIndex, uint _price) public OnlyOwner {
       
        uint newPrice = _price;
        require (msg.value == productIndex[_productIndex].price, "Price changed");
         

    }
    
    function clientSelect(uint _productIndex, uint _time) public payable {
        Client memory clientSelection = Client(true, _time);
        require (productIndex[_productIndex].isValid == true);
    } 
    uint256 public start = block.timestamp ;


function clientSelect( uint secAfter) public {
require(block.timestamp < start + secAfter * 10 minutes,"not allowed");
    
}
    
}