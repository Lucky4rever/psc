const { ethers } = require('ethers');
require('@openzeppelin/humans'); // Importing BigNumber library
// assuming 'value', 'spender' and 'amount' are variables containing the params
let value = new Number("9000000000000000000").toString(); 
let spenderAddress = "0x6c71a1d7c9cf29b5cf9f5c4e0af6bc4c4e3f9adf82d2821f938839a7eeb6f0986c915c9cdb39b92fd9d4e61a6d9a3a7a22a2716f9384efb6a42f8c963a06b51b1b";
let amount = new Number("1735689600").toString();
const txData = {
    value,
    spenderAddress: ethers.utils.getAddress(spenderAddress),
    amount, 
};