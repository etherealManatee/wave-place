async function main() {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal") //compile
    const waveContract = await waveContractFactory.deploy() //deploy
    await waveContract.deployed()
    console.log("Contract Address:", waveContract.address)
}


main()
    .then(() => process.exit(0))
    .catch(() => {
        console.error(error);
        process.exit(1)
    })