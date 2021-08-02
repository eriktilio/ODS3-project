<template>
  <div>
    <li style="margin-right: 22px;">
      <div class="btn-group">
        <button
          type="button"
          class="btn btn-secondary"
          data-bs-toggle="offcanvas"
          data-bs-target="#mySalesCanvas"
          aria-controls="mySalesCanvas"
          aria-expanded="false"
        >
          <i class="fas fa-store"></i> My sales
          <span v-if="this.mySalesList.length != 0" class="badge bg-danger">{{
            this.mySalesList.length
          }}</span>
        </button>
      </div>
    </li>
    <div
      class="offcanvas offcanvas-end"
      tabindex="-1"
      id="mySalesCanvas"
      aria-labelledby="mySalesCanvasLabel"
    >
      <div class="offcanvas-header">
        <h5 id="mySalesCanvasLabel">My sales</h5>
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
            v-for="(item, index) in mySalesList"
            :key="index"
            :disabled="item['delivered'] === true"
            data-bs-toggle="tooltip"
            data-bs-placement="left"
            v-bind:title="item['buyer']"
          >
            <div class="ms-2 me-auto">
              <div class="fw-bold">{{ item["product"]["name"] }}</div>
              {{ item["deliveryPlace"] }}
              <span class="item-description">
                Você recebe: <i class="fab fa-ethereum"></i
                >{{ item["product"]["price"] }}</span
              >
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
      mySalesList: [],
    };
  },
  mounted() {
    this.$drizzleEvents.$on("drizzle/contractEvent", (payload) => {
      const { eventName } = payload;
      if (eventName === "RegisteredOrder" || eventName === "UpdatedOrder")
        this.getMySales();
    });
  },
  created() {
    this.getMySales();
  },
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
  },
  methods: {
    async getMySales() {
      this.mySalesList = [];
      this.mySalesList = await this.drizzleInstance.contracts.SmartContract.methods
        .getOrders()
        .call({ from: this.accounts[0] });
      this.mySalesList = this.mySalesList.filter((element) => {
        return element.seller === this.$store.state.accounts.activeAccount;
      });
    },
  },
};
</script>
<style scoped>
.dropdown-toggle::after {
  display: none;
}

.item-description {
  display: block;
  font-size: 18px;
  position: relative;
  left: 189px;
}
</style>
