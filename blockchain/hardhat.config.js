require("@nomicfoundation/hardhat-toolbox");
require("@shardlabs/starknet-hardhat-plugin");

const fs = require('fs');
const path = require('path');

// Create cache directory if it doesn't exist
const cacheDir = path.join(__dirname, 'cache');
if (!fs.existsSync(cacheDir)){
    fs.mkdirSync(cacheDir);
}

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  cairo: {
    compilerOptions: {
      "--single-file": true
    }
  },
};
