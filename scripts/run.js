async function main() {
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal") //compile
    const waveContract = await waveContractFactory.deploy() //deploy
    await waveContract.deployed()
    console.log("Contract Address:", waveContract.address)

    let count = await waveContract.getTotalWaves()
    console.log(count.toNumber())

    let waveTxn = await waveContract.wave()
    await waveTxn.wait() // wait for txn to be mined

    count = await waveContract.getTotalWaves()
    console.log(count.toNumber())
}


main()
    .then(() => process.exit(0))
    .catch(() => {
        console.error(error);
        process.exit(1)
    })