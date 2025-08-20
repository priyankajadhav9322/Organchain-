const express = require('express');
const router = express.Router();
const { ethers } = require('ethers');
const contractABI = require('../contracts/OrganDonation.json');

const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
const contractAddress = process.env.CONTRACT_ADDRESS;
const contract = new ethers.Contract(contractAddress, contractABI.abi, wallet);

router.post('/match', async (req, res) => {
    try {
        const { donorAddress, recipientAddress, organ } = req.body;
        const tx = await contract.matchOrgan(donorAddress, recipientAddress, organ);
        await tx.wait();
        res.status(200).send({ success: true, txHash: tx.hash });
    } catch (err) {
        res.status(500).send({ success: false, error: err.message });
    }
});

module.exports = router;
