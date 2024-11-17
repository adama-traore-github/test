const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();  // Charger les variables depuis .env

module.exports = {
  networks: {
    sepolia: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC, // Phrase mnémonique depuis le fichier .env
        `https://sepolia.infura.io/v3/${process.env.INFURA_PROJECT_ID}` // URL Infura Sepolia
      ),
      network_id: 11155111, // ID du réseau Sepolia
      gas: 5500000, // Limite de gaz
      confirmations: 2, // Nombre de confirmations avant de considérer la transaction comme terminée
      timeoutBlocks: 200, // Temps d'attente pour un bloc
      skipDryRun: true // Passer l'étape "dry run" avant déploiement
    },
  },
  compilers: {
    solc: {
      version: "0.8.19", // Version du compilateur Solidity
    },
  },
};
