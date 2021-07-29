import Migrations from "./contracts/Migrations.json";

const options = {
  web3: {
    block: false,
    fallback: {
      type: "ws",
      url: "ws://127.0.0.1:8545",
    },
  },
  contracts: [Migrations],
  events: {},
  polls: {
    accounts: 5000,
  },
};

export default options;
