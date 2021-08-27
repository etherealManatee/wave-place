async function main() {

    const [owner, randoPerson] = await ethers.getSigners();

    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal") //compile
    const waveContract = await waveContractFactory.deploy({value: hre.ethers.utils.parseEther("0.1")}) //deploy
    await waveContract.deployed()
    console.log("Contract Address:", waveContract.address)
    console.log("Contract deployed by:", owner.address)

    let contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
    console.log("Balance: ", hre.ethers.utils.formatEther(contractBalance))

    let allWaves = await waveContract.getAllWaves()
    console.log("current stored waves: ", allWaves)

    let waveTxn = await waveContract.wave("1st wave, be a farmer")
    await waveTxn.wait()

    waveTxn = await waveContract.wave("2nd wave, embody it")
    await waveTxn.wait()

    waveTxn = await waveContract.wave("3rd wave, own it")
    await waveTxn.wait()
    
    allWaves = await waveContract.getAllWaves()
    console.log("current stored waves: ", allWaves)

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address)
    console.log("Balance updated: ", hre.ethers.utils.formatEther(contractBalance))
    // let count = await waveContract.getTotalWaves()
    // // console.log(count.toNumber())

    // let waveTxn = await waveContract.wave()
    // await waveTxn.wait() // wait for txn to be mined

    // count = await waveContract.getTotalWaves()
    // // console.log(count.toNumber())

    // waveTxn = await waveContract.connect(randoPerson).wave()
    // await waveTxn.wait()

    // count = await waveContract.getTotalWaves()

}


main()
    .then(() => process.exit(0))
    .catch(() => {
        console.error(error);
        process.exit(1)
    })