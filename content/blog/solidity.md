+++
title = "My second post"
date = 2025-01-13
+++

## How to use solidity ?

```js
const Web3 = require("web3");
let web3;

// 使用HTTPProvider连接到Infura节点
if (window.ethereum) {
  // 使用MetaMask等浏览器插件钱包
  window.web3 = new Web3(window.ethereum);
  try {
    // 请求用户授权
    await window.ethereum.enable();
    web3 = window.web3;
  } catch (error) {
    console.error("User denied account access...");
  }
} else if (typeof Web3 !== "undefined") {
  // 已有注入的Web3实例，例如 Mist 或 MetaMask
  web3 = new Web3(Web3.currentProvider);
} else {
  // 作为最后手段，使用本地节点或公共节点
  const provider = new Web3.providers.HttpProvider(
    "https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID",
  );
  web3 = new Web3(provider);
}

console.log("Connected to Ethereum node:", web3.version.api);
```
