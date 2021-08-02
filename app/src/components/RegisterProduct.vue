<template>
  <div id="register-product">
    <button
      class="btn"
      type="button"
      data-bs-toggle="offcanvas"
      data-bs-target="#offcanvasRight"
      aria-controls="offcanvasRight"
    >
      <i class="fas fa-plus-square" style="margin-right: 5px;"></i>Register
      product
    </button>

    <div
      class="offcanvas offcanvas-end"
      tabindex="-1"
      id="offcanvasRight"
      aria-labelledby="offcanvasRightLabel"
    >
      <div class="offcanvas-header">
        <h5 id="offcanvasRightLabel">Register your product</h5>
        <button
          type="button"
          class="btn-close text-reset"
          data-bs-dismiss="offcanvas"
          aria-label="Close"
        ></button>
      </div>
      <div class="offcanvas-body">
        <form
          id="formProduct"
          @submit.prevent="onSubmit"
          class="card-form"
          autocomplete="off"
        >
          <div class="form-floating mb-3">
            <input
              type="text"
              id="floatingInput01"
              class="form-control"
              v-model="nameProduct"
              placeholder="Put the product name here"
              required
            />
            <label for="floatingInput01">Name product</label>
          </div>
          <div class="form-floating mb-3">
            <input
              type="text"
              id="floatingInput02"
              class="form-control"
              v-model="plantingPlace"
              placeholder="Put the product name here"
              required
            />
            <label for="floatingInput02">Product planting place</label>
          </div>
          <div class="form-floating mb-3">
            <select
              id="floatingSelect01"
              class="form-select"
              v-model="productType"
              aria-label="Floating label select example"
              required
            >
              <option selected disabled value="">Select type...</option>
              <option value="Verduras">Verduras</option>
              <option value="Frutas">Frutas</option>
              <option value="Legumes">Legumes</option>
              <option value="Grãos e cereais">Grãos e cereais</option>
            </select>
            <label for="floatingSelect01">Product Type</label>
          </div>
          <div class="d-flex justify-content-between">
            <div class="form-floating mb-3 mr-3" style="max-width: 48%;">
              <input
                id="plantingDate"
                type="date"
                class="form-control"
                v-model="plantingDate"
                required
              />
              <label for="plantingDate">Planting date</label>
            </div>
            <div class="form-floating mb-3" style="max-width: 48%;">
              <input
                id="harvestDate"
                type="date"
                class="form-control"
                v-model="harvestDate"
                required
              />
              <label for="harvestDate">Harvest date</label>
            </div>
          </div>
          <div class="form-floating mb-3">
            <textarea
              id="floatingTextarea01"
              class="form-control"
              placeholder="Leave a description here"
              style="min-height: 98px;max-height: 98px;"
              v-model="descriptionProduct"
              required
            ></textarea>
            <label for="floatingTextarea01">Description of product</label>
          </div>
          <div class="form-floating mb-3">
            <input
              id="floatingInput03"
              type="number"
              class="form-control"
              oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
              placeholder="Put the price here"
              min="0"
              v-model="priceProduct"
              required
            />
            <label for="floatingInput03">Price in ether</label>
          </div>
          <div class="d-flex justify-content-center">
            <button
              class="btn btn-primary btn-lg d-flex align-items-center"
              type="submit"
              data-bs-dismiss="offcanvas"
            >
              Publish product
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      showForm: false,
      nameProduct: "",
      plantingPlace: "",
      productType: "",
      plantingDate: "",
      harvestDate: "",
      descriptionProduct: "",
      priceProduct: "",
    };
  },
  computed: {
    ...mapGetters("drizzle", ["drizzleInstance"]),
  },
  methods: {
    async onSubmit() {
      try {
        await this.drizzleInstance.contracts.SmartContract.methods.setProduct.cacheSend(
          this.$store.state.accounts.activeAccount,
          this.nameProduct,
          parseInt(this.priceProduct),
          this.productType,
          JSON.stringify({
            descriptionProduct: this.descriptionProduct,
            plantingPlace: this.plantingPlace,
            plantingDate: this.plantingDate,
            harvestDate: this.harvestDate,
          })
        );
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>
<style scoped>
.btn:focus {
  box-shadow: none;
}
</style>
