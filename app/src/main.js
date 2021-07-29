import Vue from "vue";
import App from "./App.vue";
import store from "./store";
import VuePageTransition from "vue-page-transition";
import drizzleVuePlugin from "@drizzle/vue-plugin";
import drizzleOptions from "./drizzleOptions";
import router from "./router";

Vue.use(VuePageTransition);
Vue.use(drizzleVuePlugin, { store, drizzleOptions });
Vue.config.productionTip = false;

new Vue({
  store,
  router,
  render: (h) => h(App),
}).$mount("#app");
