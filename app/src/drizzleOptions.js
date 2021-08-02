import SmartContract from "./contracts/SmartContract.json";

const options = {
  web3: {
    block: false,
    fallback: {
      type: "ws",
      url: "ws://127.0.0.1:7545",
    },
  },
  contracts: [SmartContract],
  events: {
    SmartContract: ["RegisteredProduct", "RegisteredOrder", "UpdatedOrder"],
  },
  polls: {
    accounts: 5000,
  },
};

export default options;
