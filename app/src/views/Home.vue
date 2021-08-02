<template>
  <div id="home">
    <NavBar />
    <div v-if="this.productList.length !== 0" class="container d-flex row">
      <Card
        v-for="item in productList"
        :key="item"
        v-bind:farmer="item['farmer']"
        v-bind:type="item['typeItem']"
        v-bind:available="item['available']"
        v-bind:title="item['name']"
        v-bind:description="item['description']"
        v-bind:price="item['price']"
        data-bs-toggle="modal"
        data-bs-target="#staticBackdrop"
      />
      <Modal
        v-for="(item, index) in productList"
        :key="index"
        v-bind:index="index"
        v-bind:title="item['name']"
        v-bind:price="item['price']"
        v-bind:type="item['typeItem']"
        v-bind:farmer="item['farmer']"
        v-bind:description="item['description']"
      />
    </div>
    <div
      v-else
      class="alert alert-info d-flex justify-content-center"
      role="alert"
    >
      Nenhum produto para exibir, <b> recarregue a página</b> ou volte depois :/
    </div>
  </div>
</template>
<script>
import NavBar from "../components/NavBar";
import Card from "../components/Card";
import Modal from "../components/Modal";
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      accounts: [],
      productList: [],
    };
  },
  mounted() {
    this.$drizzleEvents.$on("drizzle/contractEvent", (payload) => {
      const { eventName } = payload;
      if (eventName === "RegisteredProduct") this.getProducts();
    });
  },
  created() {
    this.getProducts();
  },
  components: {
    NavBar,
    Card,
    Modal,
  },
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
  },
  methods: {
    async getProducts() {
      this.productList = [];
      this.productList = await this.drizzleInstance.contracts.SmartContract.methods
        .getAllProducts()
        .call({ from: this.accounts[0] });
    },
  },
};
</script>
<style scoped>
#home {
  padding-bottom: 5em;
}
b {
  margin: 0px 5px;
}
</style>
