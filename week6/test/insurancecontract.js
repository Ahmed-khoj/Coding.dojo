const insurancecontract = artifacts.require("insurancecontract");

contract("insurancecontract", async function (accounts){

    it(
        "should add a product", async function(){
            let instance = await insurancecontract.deployed()
            await instance.addProduct(1, "iPhone 11", web3.utils.toWei('7', 'ether'), {from: accounts[0]});
        
    });

    it(
        "should check it is not offered", async function(){
            let instance = await insurancecontract.deployed()
            await instance.addProduct(1, "iPhone 11", web3.utils.toWei('7', 'ether'), {from: accounts[0]});
            let getProduct = await instance.doNotOffer(1);
    });
    
    it(
        "should check it is offered", async function(){
            let instance = await insurancecontract.deployed()
            await instance.addProduct(1, "iPhone 11", web3.utils.toWei('7', 'ether'), {from: accounts[0]});
            let getProduct = await instance.forOffer(1);
    });


});