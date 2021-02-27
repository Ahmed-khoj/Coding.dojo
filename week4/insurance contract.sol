//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;

import "../github/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";


/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
 
 
contract TechInsurance is ERC721("MyToken", "Ins") {
    
    /** 
     * Define two structs
     * 
     * 
     */
     
    mapping (uint256 => address) public _owner;
      
      
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
         
         productCounter++;
         Product memory newProduct = Product(_productId, _productName, _price, true);
         productIndex[productCounter++] = newProduct;
         
        
    }
    
    
    function doNotOffer(uint _productIndex) public {

        require (productIndex[_productIndex].offered = false, "the product is not covered");
        

    }
    
    function forOffer(uint _productIndex) public {
         require (productIndex[_productIndex].offered = true, "the product is covered");

    }
    
    function changePrice(uint _productIndex, uint _price) public OnlyOwner {
       
        //uint newPrice = _price;
        require (productIndex[_productIndex].price >= 1, "Price changed");
        
        productIndex[_productIndex].price = _price;
         

    }
    
    /**
    * @dev 
    * Every client buys an insurance, 
    * you need to map the client's address to the id of product to struct client, using (client map)
    */
    
    function buyInsurance(uint _productIndex) public payable {
        require (productIndex[_productIndex].price == msg.value, "Not correct");
        Client memory AddClient;
        AddClient.isValid = true;
        client[msg.sender][_productIndex] = AddClient;
        insOwner.transfer(msg.value);
       
    } 
    //uint256 public start = block.timestamp ;

    //function clientSelect( uint secAfter) public {
    //require(block.timestamp < start + secAfter * 10 days,"not allowed");
    
//}
    
}