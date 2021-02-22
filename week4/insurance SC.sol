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
    constructor(address payable _insOwner) public {
        insOwner = _insOwner;
    }
 
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
         
         
         Product memory newProduct = Product(_productId, _productName, _price, true);
         insOwner[msg.sender] = newProduct;
         
         
         productId[productCounter++] = newProduct;
    }
    
    
    function changeFalse(uint _productIndex) public {
        require (productIndex[_productIndex].offered = false, "the product is not covered");
        

    }
    
    function changeTrue(uint _productIndex) public {
         require (productIndex[_productIndex].offered = true, "the product is covered");

    }
    
    function changePrice(uint _productIndex, uint _price) public {
       Product memory newPrice = productIndex;
        require (productIndex[_productIndex].price = newPrice);

    }
    
    function clientSelect(uint _productIndex) public payable {
        
        insOwner[msg.sender] = productIndex;
        require (productIndex[_productIndex].isValid == true);
        require (msg.sender == productIndex[_productIndex].time);
        
    } 
    
}