<template>
  <vue-page-transition v-if="isDrizzleInitialized" name="fade">
    <router-view />
  </vue-page-transition>
  <div v-else class="spinner-border" role="status"></div>
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
