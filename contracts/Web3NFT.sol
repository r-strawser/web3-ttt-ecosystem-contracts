// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract Web3NFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    mapping(address => uint256[]) private balance;

    constructor() ERC721("Web3 TTT Token", "WEB3T") {}


    // update the your balance
    function updateMyNFTs(uint256 tokenId) public {
        balance[msg.sender].push(tokenId);
    }

    // return all NFTs that you minted
    function getMyNFTs() public view returns (uint256[] memory) {
        return balance[msg.sender];
    }

    // create an NFT with the given IPFS URL we created from our custom metadata file.
    function createToken(string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();

        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        updateMyNFTs(tokenId);
        

        return tokenId;
    }

    // mints a token to your friend's (recipients) address
    function mintTokenToAddress(address friend, string memory tokenURI) 
    public
    returns (uint256) {

      // increment the token counter
      _tokenIds.increment();
      uint256 newItemId = _tokenIds.current();
      
      _mint(friend, newItemId);
      _setTokenURI(newItemId, tokenURI);
      updateMyNFTs(newItemId);

      return newItemId;
  }

  function getTokensOfOwner(address _owner) external view returns(uint256[] memory) {
    uint256 tokenCount = balanceOf(_owner);

    if (tokenCount == 0) {
        // Return an empty array
        return new uint256[](0);
    } else {
        uint256[] memory result = new uint256[](tokenCount);
        uint256 totalItemCount = _tokenIds.current();
        uint256 resultIndex = 0;

        // We count on the fact that all videos have IDs starting at 1 and increasing
        // sequentially up to the totItemCount count.
        for (uint i = 1; i <= totalItemCount; i++) {
            if (ownerOf(i) == _owner) {
                result[resultIndex] = i;
                resultIndex++;
            }
        }

        return result;
    }
}


    
    
}