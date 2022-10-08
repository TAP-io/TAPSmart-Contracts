// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


import "hardhat/console.sol";

contract ContactList{

    struct List {
        string number;
        string h;
    }
    
    address payable public owner;

    mapping(string=> bool) public checkTapUser;
    mapping(address=> List) private completeList;

    mapping(address=> bool) private onBoard;


    event ListCreated(address indexed _owner, string indexed _number);


    constructor() payable {
        owner = payable(msg.sender);
    }

    function createList(string memory _list, string memory _number) public {
        require(onBoard[msg.sender] == false, "You alredy registered");
        require(checkTapUser[_number] == false, "Phone number alredy registered to an account");

        checkTapUser[_number] = true;
        completeList[msg.sender] = List(_list, _number);
        onBoard[msg.sender] = true;

        emit ListCreated(msg.sender, _number);

    }

    function updateList(string memory _list) public {
        require(onBoard[msg.sender], "You are not registered");
        completeList[msg.sender].h = _list;
    }

    function getList() public view returns(string memory) {
        require(onBoard[msg.sender], "You are not registered");
        
        return completeList[msg.sender].h;
        
    }
}
