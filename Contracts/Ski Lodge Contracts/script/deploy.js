const NFT = await Headers.ethers.getContractFactory("NFT");
const nft = await NFT.deploy();

await nft.deployed();

console.log("NFT deployed to:", nft.address);