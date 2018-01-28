module.exports = {
  networks: {
    development: {  //ganache
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    qa: {         //geth-rinkeby
      host: "127.0.0.1",
      port: 9545,
      network_id: "4" // Match any network id
    },
    prod: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "1" // livenet
    }
  }
};