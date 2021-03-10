//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
 
 
contract insurancecontract is ERC721 ("myToken" , "Ins") {
    
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
    
    mapping (uint256 => address) public _owner;
    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    
  
  
    
    
    
    
    uint productCounter;
    
    address payable insOwner;
    
    address public Owner;
    modifier OnlyOwner (){
        require( Owner == msg.sender, "you are not the owner");
        _;
    }
  
  
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
         
         
         Product memory newProduct = Product(_productId, _productName, _price, true);
         productCounter++;
         productIndex[productCounter++] = newProduct;
         _mint(msg.sender, productCounter);
         
        
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
        require (productIndex[_productIndex].price == 0, "not valid");
        Client memory AddClient;
        AddClient.isValid = true;
        AddClient.time = block.number;
        client[msg.sender][_productIndex] = AddClient;
        insOwner.transfer(msg.value);
       
    } 

      /* this function is correct and you can add more required options
    *like the address to not 0 and not the sender. 
    */
  
    //uint256 public start = block.timestamp ;


    //function clientSelect( uint secAfter) public {
    //require(block.timestamp < start + secAfter * 10 days,"not allowed");
    
//}
    
}