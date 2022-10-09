// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract TapNFT is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address public managerContract;

    address public owner;

    constructor() ERC721("TapNFT", "TNFC") {
        owner = msg.sender;
    }

    function mintToNFC(address player, string memory tokenURI)
        public
        returns (uint256)
    {
        require(msg.sender == managerContract)
        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        return newItemId;
    }

    function setManager(address _manager){
        require(msg.sender == owner) 
        managerContract = _manager;
    }
}