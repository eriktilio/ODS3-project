<template>
  <div
    v-if="item['available'] != false"
    class="card shadow"
    style="width: 18rem; margin: 15px 15px;"
  >
    <div class="card-body">
      <span class="badge rounded-pill bg-secondary">{{ type }}</span>
      <h5 class="card-title">{{ title }}</h5>
      <p class="card-text">
        {{ subtitle["descriptionProduct"] }}
      </p>
      <h3 class="price text-end"><i class="fab fa-ethereum"></i>{{ price }}</h3>
      <button
        v-if="farmer != this.$store.state.accounts.activeAccount"
        type="button"
        class="btn btn-dark"
      >
        Comprar
      </button>
    </div>
  </div>
</template>
<script>
export default {
  props: ["type", "title", "description", "price", "farmer"],
  data() {
    return {
      subtitle: "",
    };
  },
  created() {
    this.subtitle = JSON.parse(this.description);
  },
};
</script>
<style scoped>
.card {
  cursor: pointer;
}

.card-text {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.badge,
.price {
  position: relative;
  float: right;
}

.card:hover {
  transform: scale(1.1);
  background-color: #d3d3d3;
}
</style>
