const Web3NFT = artifacts.require('Web3NFT');


contract('Web3NFT', (accounts) => {
    it('sets the owner of the contract to the first account', async () => {
      const instance = await Web3NFT.deployed();
      assert.equal(
        await instance.owner.call(),
        accounts[0],
        'owner is first account',
        console.log("owner: "+accounts[0])
      );
    });

    
    it('should output the three tokenIDs we minted to ourselves', async () => {
        const instance = await Web3NFT.deployed();
        await instance.createToken("https://ipfs.io/ipfs/Qm...1");
        await instance.createToken("https://ipfs.io/ipfs/Qm...2");
        await instance.createToken("https://ipfs.io/ipfs/Qm...3");

        items = await instance.getMyNFTs();
        
        console.log("items: ", items.toString());
    });
  
  
    // More tests...
  });