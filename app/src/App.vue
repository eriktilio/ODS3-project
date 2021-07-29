<template>
  <router-view v-if="isDrizzleInitialized" />
</template>

<script>
import { mapGetters } from "vuex";
export default {
  computed: { ...mapGetters("drizzle", ["isDrizzleInitialized"]) },
};
</script>

<style></style>
