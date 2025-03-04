const Web3 = require('web3');

// Підключення до мережі (використовуйте Infura або локальний вузол)
const web3 = new Web3('https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID');

// Адреса вашого контракту
const contractAddress = '0x1234567890abcdef1234567890abcdef12345678'; // Замініть на адресу вашого контракту

// ABI вашого контракту (скопіюйте з компілятора Remix або Truffle)
const abi = [
    {
        "inputs": [
            { "internalType": "uint256", "name": "amount", "type": "uint256" },
            { "internalType": "uint256", "name": "deadline", "type": "uint256" },
            { "internalType": "bytes", "name": "signature", "type": "bytes" }
        ],
        "name": "approve",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
];

// Створення екземпляру контракту
const contract = new web3.eth.Contract(abi, contractAddress);

// Ваша адреса (адреса, з якої викликається транзакція)
const yourAddress = '0x1234567890abcdef1234567890abcdef12345678'; // Замініть на адресу вашого гаманця

// Параметри для виклику функції approve
const amount = web3.utils.toBN('9000000000000000000'); // 9 ether у wei
const deadline = web3.utils.toBN('1735689600'); // Час дедлайну
const signature = '0x6c71a1d7c9cf29b5cf9f5c4e0af6bc4c4e3f9adf82d2821f938839a7eeb6f0986c915c9cdb39b92fd9d4e61a6d9a3a7a22a2716f9384efb6a42f8c963a06b51b1b'; // Підпис

// Виклик функції approve
async function callApprove() {
    try {
        const tx = await contract.methods.approve(amount, deadline, signature).send({ from: yourAddress });
        console.log('Transaction hash:', tx.transactionHash);
    } catch (error) {
        console.error('Error:', error);
    }
}

callApprove();