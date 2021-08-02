<template>
  <vue-page-transition v-if="isDrizzleInitialized" name="fade">
    <router-view />
  </vue-page-transition>
  <div
    v-else
    class="spinner-border"
    style="
          width: 10rem;
          height: 10rem;
          position: fixed;
          top: 40%;
          left: 45%;
        "
    role="status"
  ></div>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  computed: { ...mapGetters("drizzle", ["isDrizzleInitialized"]) },
};
</script>

<style>
.spinner-border {
  height: 150px;
  width: 150px;
}
</style>
