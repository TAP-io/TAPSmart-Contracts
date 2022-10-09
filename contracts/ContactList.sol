// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ContactList{

    using Counters for Counters.Counter;
    struct List {
        string number;
        mapping(address=> string) contacts;
        Counters.Counter numOfContacts;
    }

    struct Contact {
        address _ctk;
    }
    
    address payable public owner;

    //Check if phone number is registered
    mapping(string=> bool) public checkTapUser;

    // Main mapping, it gives all information from contacts
    mapping(address=> List) private completeList;

    //Phone number to address
    mapping(string => Contact) private phoneToA;

    // maping just for address iteration
    mapping(address=> mapping(uint => address)) private iteration;

    // check if address already is registered
    mapping(address=> bool) private onBoard;


    event ListCreated(address indexed _owner, string indexed _number);

    event NewContact(address indexed _owner, address indexed _contact);


    constructor() payable {
        owner = payable(msg.sender);
    }

    function createList(string memory _number) public {
        require(onBoard[msg.sender] == false, "You alredy registered");
        require(checkTapUser[_number] == false, "Phone number alredy registered to an account");

        checkTapUser[_number] = true;
        completeList[msg.sender].number = _number;
        onBoard[msg.sender] = true;

        emit ListCreated(msg.sender, _number);

    }


    function addContact(string memory _info, address _addressContact, string memory _contact) public {
        require(onBoard[msg.sender], "You are not registered");

        completeList[msg.sender].numOfContacts.increment();
        uint d = completeList[msg.sender].numOfContacts.current();

        phoneToA[_contact]._ctk = _addressContact;

        iteration[msg.sender][d] = _addressContact;
        completeList[msg.sender].contacts[_addressContact] = _info;

        emit NewContact(msg.sender, _addressContact);
    }

    function getContactInfo(string memory _phoneNumber) public view returns(string memory) {
        require(onBoard[msg.sender], "You are not registered");
        
        return (completeList[msg.sender].contacts[phoneToA[_phoneNumber]._ctk]);
    }

    function getAllContacts() public view returns(address[] memory) {
        uint contactCount = completeList[msg.sender].numOfContacts.current();

        address[] memory _contacts = new address[](contactCount);

        for (uint i = 0; i < contactCount; i++) {
            uint currentId = i + 1;
            address currentContact = iteration[msg.sender][currentId];
            _contacts[i] = currentContact;
        }

        return (_contacts);
    }

    function getUserNumber() public view returns(string memory) {
        require(onBoard[msg.sender], "You are not registered");

        return (completeList[msg.sender].number);
    }
}
