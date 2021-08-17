async function main() {
    const [owner, randoPerson] = await ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal") //compile
    const waveContract = await waveContractFactory.deploy() //deploy
    await waveContract.deployed()
    console.log("Contract Address:", waveContract.address)
    console.log("Contract deployed by:", owner.address)

    let count = await waveContract.getTotalWaves()
    // console.log(count.toNumber())

    let waveTxn = await waveContract.wave()
    await waveTxn.wait() // wait for txn to be mined

    count = await waveContract.getTotalWaves()
    // console.log(count.toNumber())

    waveTxn = await waveContract.connect(randoPerson).wave()
    await waveTxn.wait()

    count = await waveContract.getTotalWaves()

}


main()
    .then(() => process.exit(0))
    .catch(() => {
        console.error(error);
        process.exit(1)
    })