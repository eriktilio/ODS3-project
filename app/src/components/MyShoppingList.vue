<template>
  <div>
    <li style="margin-right: 22px;">
      <div class="btn-group">
        <button
          type="button"
          class="btn btn-secondary"
          data-bs-toggle="offcanvas"
          data-bs-target="#myShoppingCanvas"
          aria-controls="myShoppingCanvas"
          aria-expanded="false"
        >
          <i class="fas fa-shopping-cart"></i> My shopping
          <span
            v-if="this.myShoppingList.length != 0"
            class="badge bg-danger"
            >{{ this.myShoppingList.length }}</span
          >
        </button>
      </div>
    </li>
    <div
      class="offcanvas offcanvas-end"
      tabindex="-1"
      id="myShoppingCanvas"
      aria-labelledby="myShoppingCanvasLabel"
    >
      <div class="offcanvas-header">
        <h5 id="myShoppingCanvasLabel">My shopping</h5>
        <button
          type="button"
          class="btn-close text-reset"
          data-bs-dismiss="offcanvas"
          aria-label="Close"
        ></button>
      </div>
      <div class="offcanvas-body">
        <ol class="list-group list-group-numbered">
          <li
            class="list-group-item d-flex justify-content-between align-items-start"
            v-for="(item, index) in myShoppingList"
            :key="index"
            :disabled="item['delivered'] === true"
            data-bs-toggle="tooltip"
            data-bs-placement="left"
            v-bind:title="item['seller']"
          >
            <div class="ms-2 me-auto">
              <div class="fw-bold">{{ item["product"]["name"] }}</div>
              {{ item["deliveryPlace"] }}
              <button
                type="button"
                @click.prevent="() => confirmedPurchase(index)"
                class="btn btn-success btn-sm"
              >
                Confirm delivery
              </button>
            </div>
            <span
              v-if="item['delivered'] === false"
              class="badge bg-danger rounded-pill"
              >Não entregue</span
            >
            <span v-else class="badge bg-success rounded-pill">Entregue</span>
          </li>
        </ol>
      </div>
    </div>
  </div>
</template>
<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      accounts: [],
      myShoppingList: [],
    };
  },
  mounted() {
    this.$drizzleEvents.$on("drizzle/contractEvent", (payload) => {
      const { eventName } = payload;
      if (eventName === "RegisteredOrder" || eventName === "UpdatedOrder")
        this.getMyShopping();
    });
  },
  created() {
    this.getMyShopping();
  },
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
  },
  methods: {
    async getMyShopping() {
      this.myShoppingList = [];
      this.myShoppingList = await this.drizzleInstance.contracts.SmartContract.methods
        .getOrders()
        .call({ from: this.accounts[0] });
      this.myShoppingList = this.myShoppingList.filter((element) => {
        return element.buyer === this.$store.state.accounts.activeAccount;
      });
      console.log(this.myShoppingList);
    },
    async confirmedPurchase(index) {
      try {
        await this.drizzleInstance.contracts.SmartContract.methods.confirmedPurchase.cacheSend(
          index
        );
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
<style scoped>
.dropdown-toggle::after {
  display: none;
}

.btn-success {
  position: absolute;
  left: 196px;
}
</style>
