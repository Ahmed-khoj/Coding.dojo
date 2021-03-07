const insurancecontract = artifacts.require("insurancecontract");

contract("insurancecontract", async function (accounts){

    it(
        "should add a product", async function(){
            let instance = await insurancecontract.deployed()
            await instance.addProduct("iPhone 11", web3.utils.toWei('7', 'ether'), {from: accounts[0]});
        
    });

    it(
        "should check it is not offered", async function(){
            let instance = await insurancecontract.deployed()
            await instance.addProduct("iPhone 11", web3.utils.toWei('7', 'ether'), {from: accounts[0]});
            let getProduct = await instance.doNotOffer(1);
            assert(getProduct.status === true, "Error: the product is not covered");
    });
    
    it(
        "should check it is offered", async function(){
            let instance = await insurancecontract.deployed()
            await instance.addProduct("iPhone 11", web3.utils.toWei('7', 'ether'), {from: accounts[0]});
            let getProduct = await instance.forOffer(1);
            assert(getProduct.status === true, "the product covered");
    });

    it(
  "Try to see if user pays price for offered product", async function(){
      let user = accounts[0];
      let price = web3.utils.toWei('7', 'ether');
      let userPrice = 3000000000000000000;
      let instance = await insurancecontract.deployed()
      await instance.addProduct("iPhone 11", web3.utils.toWei('7', 'ether'), {from: user[0]});
      let balance = web3.eth.getBalance(user);
      assert.equal(userPrice === price , "The price is not enough!");
      let getProduct = await instance.doNotOffer(1);
      assert(getProduct.status === true , "Error: the product is not covered");
      assert(getProduct.amount.toNumber() === price , "The price is not enough!");
  
    });

});



