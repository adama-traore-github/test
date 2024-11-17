const UserToken = artifacts.require("UserToken");

module.exports = function (deployer) {
  // Paramètres à passer au contrat
  const name = "User Token";
  const symbol = "UTK";
  const totalSupply = 1000000;
  const decimals = 18;  // Décimales

  // Déployer le contrat avec les paramètres dans l'ordre correct
  deployer.deploy(UserToken, name, symbol, totalSupply, decimals);
};
