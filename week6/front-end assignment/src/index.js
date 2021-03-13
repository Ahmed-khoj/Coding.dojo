import Web3 from "web3";
import metaCoinArtifact from "/Users/aak/Desktop/week5/insContract/build/contracts/insurancecontract.json"

const App = {
  web3: null,
  account: null,
  meta: null,

  start: async function() {
    const { web3 } = this;

    try {
      // get contract instance
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = metaCoinArtifact.networks[networkId];
      this.meta = new web3.eth.Contract(
        metaCoinArtifact.abi,
        deployedNetwork.address,
      );

      // get accounts
      const accounts = await web3.eth.getAccounts();
      this.account = accounts[0];

      //this.refreshBalance();
    } catch (error) {
      console.error("Could not connect to contract or chain.");
    }
    this.setStatus("your address is " + this.account)
  },

  //refreshBalance: async function() {
      //const { getBalance } = this.meta.methods;
      //const balance = await getBalance(this.account).call();

      //const balanceElement = document.getElementsByClassName("balance")[0];
      //balanceElement.innerHTML = balance;
  //},

  addProduct: async function() {
    const { addProduct } = this.meta.methods;
    const productName = document.getElementById("productName").value;
    //this.setStatus("Initiating transaction... (please wait)");

    await addProduct(productName).send({ from: this.account });

    this.setStatus("Product added" + this.account);
  },

  buyInsurance: async function (){
    const { buyInsurance } = this.meta.methods;
    const id = parseInt(document.getElementById("id").value);
    await buyInsurance(id).call().then(function(res){
      console.log(res)
    
});

  },


payment: async function (){
  const { payment } = this.meta.methods;
  const id = document.getElementById("id").value;
  const price = document.getElementById("price").value;

  await payment(id).send({ from: this.account, value:price }).then(function(res){
    console.log(res)
  });

  // this.setStatus("You have a new car "+ buy);

},


setStatus: function(message) {
  const status = document.getElementById("status");
  status.innerHTML = message;
},
};

window.App = App;

window.addEventListener("load", function() {
  if (window.ethereum) {
    // use MetaMask's provider
    App.web3 = new Web3(window.ethereum);
    window.ethereum.enable(); // get permission to access accounts
  } else {
    console.warn(
      "No web3 detected. Falling back to http://127.0.0.1:9545. You should remove this fallback when you deploy live",
    );
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    App.web3 = new Web3(
      new Web3.providers.HttpProvider("http://127.0.0.1:9545"),
    );
  }

  App.start();
});
