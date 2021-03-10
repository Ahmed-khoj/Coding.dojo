//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;


/**
 * @title Tech Insurance tor
 * @dev complete the functions
 */
 
 
contract insurancecontract {
    
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
    
    mapping (uint256 => address) public _owners;
    mapping (address => uint256) public _balances;

    
     function ownerOf(uint256 tokenId) public view  returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }
    
     function _transfer(address from, address to, uint256 tokenId) public  {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
    }
    
    function mint(address to , uint256 tokenId)public {
        require(to != address(0), "ERC721: mint to the zero address");
        _balances[to] += 1;
        _owners[tokenId] = to;
    }
     function _exists(uint256 tokenId) public view  returns (bool) {
        return _owners[tokenId] != address(0);
    }
  
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
         mint(msg.sender, productCounter);
         
        
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
        require(_owners[_productIndex] != address(0));
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
    function transferID( address to, uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender,"only owner" );
        _transfer(msg.sender, to, tokenId);
    }
    
    function refund(uint amountRequested) public OnlyOwner returns(bool) {
    require(amountRequested > 0);
    require(amountRequested <= _balances[msg.sender]);
    _balances[msg.sender] -= amountRequested;
    msg.sender.transfer(amountRequested);
    return true;
}
  
    //uint256 public start = block.timestamp ;


    //function clientSelect( uint secAfter) public {
    //require(block.timestamp < start + secAfter * 10 days,"not allowed");
    
//}
    
}