<template>
  <!-- Modal -->
  <div
    class="modal fade"
    id="staticBackdrop"
    data-bs-backdrop="static"
    data-bs-keyboard="false"
    tabindex="-1"
    aria-labelledby="staticBackdropLabel"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="staticBackdropLabel">
            {{ title }}
          </h5>
          <span class="badge bg-primary">{{ type }}</span>
        </div>
        <div class="modal-body">
          <div>
            <p class="fw-bolder">Farmer Hash {{ farmer }}</p>
            <p class="fw-light">
              <i class="fas fa-map-marked-alt" style="margin-right: 8px;"></i
              >{{ this.subtitle["plantingPlace"] }}
            </p>
            <p class="fw-light">
              {{ this.subtitle["descriptionProduct"] }}
            </p>
            <p class="fw-normal d-flex justify-content-between">
              <span
                ><b>Platting Date:</b> {{ this.subtitle["plantingDate"] }}</span
              >
              <span
                ><b>Haverst Date:</b> {{ this.subtitle["plantingDate"] }}</span
              >
            </p>
          </div>
          <form id="form-modal" autocomplete="off" @submit.prevent="onSubmit">
            <div class="form-floating mb-3">
              <input
                type="text"
                class="form-control"
                id="floatingInput"
                v-model="localDelivery"
                placeholder="Your local delivery here"
                required
              />
              <label for="floatingInput">Delivery place</label>
            </div>
            <div class="d-flex justify-content-end">
              <button
                type="button"
                class="btn btn-secondary"
                style="margin-right: 15px;"
                data-bs-dismiss="modal"
              >
                Close
              </button>
              <button type="submit" class="btn btn-primary">
                Buy item
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { mapGetters } from "vuex";

export default {
  props: ["title", "index", "type", "farmer", "description", "price"],
  data() {
    return { accounts: [], localDelivery: "", subtitle: "" };
  },
  created() {
    this.subtitle = JSON.parse(this.description);
  },
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
  },
  methods: {
    async onSubmit() {
      console.log("Sendo enviado: ", this.index, this.localDelivery);
      try {
        await this.drizzleInstance.contracts.SmartContract.methods.buyProduct.cacheSend(
          this.index,
          this.localDelivery,
          {
            from: this.accounts[0],
            value: this.price,
          }
        );
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
<style scoped>
.modal-body {
  user-select: none;
}
</style>
