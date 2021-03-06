require('babel-register')({
  ignore: /node_modules\/(?!openzeppelin-solidity\/test\/helpers)/
});
require('babel-polyfill');

 module.exports = {
   networks: {
     development: {
       host: 'localhost',
       port: 8545,
       network_id: '*', // eslint-disable-line camelcase
     },
     testrpc: {
       host: 'localhost',
       port: 8545,
       network_id: '*', // eslint-disable-line camelcase
     }
   }
 };
