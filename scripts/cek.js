// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const youtubeFactory = await hre.ethers.getContractFactory("DocumentStorage");
  const yt = await youtubeFactory.attach("0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0");

  const count = await yt.addDocument("Berkas Pengelolaan","axasdas-asdasda-dsas-dasda","weqweq-weq-asa-sd-svsdvsd-ds","pengajuankedua","HASH123");
  console.log(count)

  const pemilik = await yt.documentCount();
  console.log(pemilik);

  const documentData = await yt.documents(1);
  console.log(documentData);
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
