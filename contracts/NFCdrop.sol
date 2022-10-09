// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./TapNFT.sol";

contract NFCdrop{ 

    using Counters for Counters.Counter;
    Counters.Counter private _Ids;

    address public owner;

    TapNFT public nftContract;
    uint256 public nftShared;

    event Dropped(address indexed _owner, string _nft)

    mapping(string=> string) private uuidToNFT;

    // Needs to be chnaged on the NFT contrtact
    mapping(string=> bool) private nftCheck;

    //Change in createPairs
    mapping(string=> bool) private nfcCheck;



    string private uris[6]  = 
    ["https://bafkreibcqkojvkeperfgqbvy6764fzyfihicuhqwtar3eud7rsobqcnage.ipfs.nftstorage.link/",
     "https://bafkreic6c5763cvk34tc6jekrwzvfjl4umpdav7ncughqkaual65h5p4me.ipfs.nftstorage.link/", 
     "https://bafkreiewqsorjuvgflq2xl325gbw3xaazexkofj7acivqaupej4xwia56e.ipfs.nftstorage.link/", 
     "https://bafkreibtlrjxvi4dmllvaozbc2hwrpkpxzwzvavv2py67ytnem45qjk24a.ipfs.nftstorage.link/", 
     "https://bafkreihcad54eltqhj5f4yddx7yqkcx6km55ay2hyqvbi3hn5gicf5tfdq.ipfs.nftstorage.link/", 
     "https://bafkreieejqxkspw6olnqh42twqkm5m7sxydrvykglni5thz22bnupdrmsu.ipfs.nftstorage.link/",
    ];



    constructor(TapNFT _NFTcontract) {
        owner = msg.sender;
        nftContract = _NFTcontract;
    }

    function createPairs(string memory _uuid, string memory _nftID) public {
        require(msg.sender == owner, "You are not the owner fo this")
        require(nftCheck, "Wrong NFT")
        require(!nfcCheck, "this NCF tag has already been used")

        uuidToNFT[_uuid] = _nftID;
        nfcCheck[_uuid] = true;
    }

    function tapNFC(string memory _uuid) public returns(uint256){
        require(nfcCheck,"NFC tag not configured")
        uint256 uriIndex = _Ids.current();
        uint256 NFT =  nftContract.mintToNFC(msg.sender, uris[uriIndex]);

        if (_Ids < 6){
            _Ids.increment();
        }

        return(NFT)
    }



}