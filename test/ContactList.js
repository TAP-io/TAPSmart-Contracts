const { expect } = require("chai");
const { ethers } = require("hardhat")


describe("ContactList", function () {
  
  

  it("Should create list", async function () {
    const ContactList = await ethers.getContractFactory("ContactList")
    const contactList = await ContactList.deploy()
    await contactList.deployed()

    const [owner] = await ethers.getSigners();
     
    await expect(contactList.createList("6462269334")).to.emit(contactList, "ListCreated").withArgs(owner.address, "6462269334")
  
    
  })

  it("Should Add Contact", async function() {
    const ContactList = await ethers.getContractFactory("ContactList")
    const contactList = await ContactList.deploy()
    await contactList.deployed()

    const [owner, otherAccount] = await ethers.getSigners();

    await contactList.createList("6462269334")
    

    await expect(contactList.addContact("IPFS-HASH", otherAccount.address, "49855334" )).to.emit(contactList, "NewContact").withArgs(owner.address, otherAccount.address)
  
    const account = await contactList.getAllContacts()

    expect(account[0]).to.equal(otherAccount.address)
  })

  it("Should get Contact Info", async function () {
    const ContactList = await ethers.getContractFactory("ContactList")
    const contactList = await ContactList.deploy()
    await contactList.deployed()

    const [owner, otherAccount] = await ethers.getSigners();

    await contactList.createList("6462269334")

    await expect(contactList.addContact("IPFS-HASH", otherAccount.address, "49855334" )).to.emit(contactList, "NewContact").withArgs(owner.address, otherAccount.address)

    const info = await contactList.getContactInfo("49855334")

    expect(info).to.equal("IPFS-HASH")
  })

  it("Should get Number", async function () {
    const ContactList = await ethers.getContractFactory("ContactList")
    const contactList = await ContactList.deploy()
    await contactList.deployed()

    await contactList.createList("6462269334")

    const number = await contactList.getUserNumber()

    expect(number).to.equal("6462269334")
  })
});
