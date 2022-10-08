const { expect } = require("chai");
const { ethers } = require("hardhat")


describe("ContactList", function () {
  
  /*const auth =
    'Basic ' + Buffer.from("2Fr7mLPnqoL3vB7WTEsFopXTvX9" + ':' + "945f308ebc0cc638a461ced4f7926a75").toString('base64');
  const client = ipfs({
    host: 'ipfs.infura.io',
    port: 5001,
    protocol: 'https',
    headers: {
        authorization: auth,
    },
  });*/

 
  

  it("Should create list", async function () {
    const ContactList = await ethers.getContractFactory("ContactList")
    const contactList = await ContactList.deploy()
    await contactList.deployed()

    
    await contactList.createList("afasfsa", "6462269334")

    const list = await contactList.getList()
    
    expect(list).to.equal("afasfsa")
  
    
  })

  it("Should Update list", async function() {
    const ContactList = await ethers.getContractFactory("ContactList")
    const contactList = await ContactList.deploy()
    await contactList.deployed()

    await contactList.createList("afasfsa", "6462269334")
    
    await contactList.updateList("Hello")

    const list = await contactList.getList()

    expect(list).to.equal("Hello")
    
  })

  it("Should get number", async function () {
    const ContactList = await ethers.getContractFactory("ContactList")
    const contactList = await ContactList.deploy()
    await contactList.deployed()

    await contactList.createList("afasfsa", "6462269334")

    const number = await contactList.getNumber()

    expect(number).to.equal("6462269334")
  })
});
