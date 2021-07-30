<template>
  <div id="home">
    <NavBar />
    <div class="container-fluid row">
      <Card
        v-for="i in 10"
        :key="i"
        type="comida"
        title="Produto"
        subtitle="Descrição do bichão"
        price="30"
      />
    </div>
  </div>
</template>
<script>
import NavBar from "../components/NavBar";
import Card from "../components/Card";
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      productList: [],
    };
  },
  created() {
    this.getProducts();
  },
  components: {
    NavBar,
    Card,
  },
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
  },
  methods: {
    async getProducts() {
      this.productList = [];
      let lengthProductList = await this.drizzleInstance.contracts.SmartContract.methods.getLengthProductList();
      for (let i = 0; i < lengthProductList; i++) {
        this.productList.push(
          await this.drizzleInstance.contracts.SmartContract.methods.getProduct(
            i
          )
        );
      }
    },
  },
};
</script>
<style scoped>
#home {
  padding-bottom: 5em;
}
</style>
