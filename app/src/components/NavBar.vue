<template>
  <div id="Nav">
    <nav class="navbar fixed-top navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">
        <div class="navbar-brand d-flex align-items-center">
          <img
            src="../../public/farm.png"
            height="40"
            width="40"
            class="d-inline-block align-text-top"
          />
          <h4>AgroFácil!</h4>
        </div>
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
          aria-controls="navbarNav"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div
          class="collapse navbar-collapse d-flex justify-content-end"
          id="navbarNav"
        >
          <ul class="navbar-nav">
            <li class="nav-item">
              <RegisterProduct />
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <div class="card">
      <div class="card-body">
        <ul class="list-group list-group-horizontal">
          <li class="list-group-item d-flex align-items-center">
            <i class="fas fa-shopping-bag fa-2x"></i>Comprar nunca foi tão bom
            :D
          </li>
          <li class="list-group-item d-flex align-items-center">
            <i class="fas fa-dollar-sign fa-2x"></i>Aqui os melhores preços!
          </li>
          <li class="list-group-item d-flex align-items-center">
            <i class="fas fa-gift fa-2x"></i>E os melhores produtos ;)
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>
<script>
import RegisterProduct from "../components/RegisterProduct";

export default {
  components: {
    RegisterProduct,
  },
};
</script>
<style scoped>
h4 {
  margin-bottom: -0.5rem;
  margin-left: 3px;
}

.card {
  margin-top: 66px;
  border-radius: 0px;
}

.list-group-item {
  border: none;
}

.fas {
  margin-right: 10px;
}

.fa-shopping-bag {
  color: grey;
}

.fa-dollar-sign {
  color: #118c4d;
}

.fa-gift {
  color: red;
}
</style>
