<?php

require_once '../includes/conexion.php';  
require_once 'includes/header.php';

	if(!empty($_GET['articulo'])){
		$articulo = $_GET['articulo'];
		$_SESSION['articulo'] = $articulo;

	}else{
		header("Location: usuario/");
	}




    $idusuario=$_SESSION['id_usuario'];		
	$_SESSION['rol_']= 0 ; 

	#$sql = "call mis_grupos($idusuario)";
    $sql = 'SELECT * FROM articulo WHERE ar_id = ?';
    $query = $pdo->prepare($sql);
    $query->execute(array($articulo));
    $result = $query->fetch(PDO::FETCH_ASSOC);
?>

<main class="app-content">
    <div class="row">
	    <div class="col-md-12 text-center  border shadow p-2 bg-info text-white">
		    <h2 class="display-4">Pagos</h2>
	  	</div>
	  	
	    <seccion class="col-md-12 text-star border mt-3 p-4 bg-light ">
			<!-- seccion 1 datos Personales -->
			<div class="pago col-md-12 mb-3	">
				<h4>1 - Carta de Regalo</h4>
				<div class="letras">
					<h4 class>Regalo de:  <?= $_SESSION['nombre']; ?> </h4>
					<textarea class="p-2" name="" id="" cols="30" rows="10"></textarea>
				</div>
			</div>

			<!-- seccion 2 Metodo de pago -->
			<div class="pago col-md-12 mb-3">
				<h4>2 - Método de Pago</h4>
				<div class="metodo-pago">
					<label><input type="radio" name="metodo-pago" value="transferencia">Transferencia</label>
					<label><input type="radio" name="metodo-pago" value="personal">Personal</label>
				</div>
			</div>
			<!-- seccion 3 Revision del articulo -->
			<div class="pago col-md-12 mb-3">
				<h4>2 - Método de Pago</h4>
				<div class="metodo-pago">
					<label><input type="radio" name="metodo-pago" value="transferencia">Transferencia</label>
					<label><input type="radio" name="metodo-pago" value="personal">Personal</label>
				</div>
			</div>

<!-- 
			<div class="bag-product">
				<div class="image">
					<img src="https://www.elenanelmes.com/images/test/ui/suunto_d4i_novo_sun_front_dive_metric.png" class="product-image">
				</div>
				<div class="description">
					<p class="product-code small muted">Product code: SS022592000</p>
					<h1>Suunto D4i Novo</h1>
					<p>Sun</p>
					<p class="description-text">An easy-to-use dive computer with freedive mode and air integration.</p>
					<p style="margin-bottom: 0.5rem;">One Size</p>
					<h2>$825.00</h2>
					<div class="quantity-wrapper">
						<div>
							<label for="quantity" style="margin-right: 0.5rem;">Quantity:</label>
							<select name="quantity" style="margin-bottom: 1rem;">
								<option value disabled>Please select</option>
								<option value="1" selected>1</option>
								<option value="2">2</option>
								<option value="3">3</option>
							</select>
						</div>
						<button class="btn-remove">Remove</button>
					</div>
				</div>
			</div> -->

			<!-- inicio -->
	<!-- Font Awesome Link -->
	
<div class="modal clearfix">
    <div class="modal-product">
      <div class="product">

        <!-- Slideshow container -->
        <div class="product-slideshow">

          <!-- Full-width images with number and caption text -->
          <div class="productSlides fade">
            <img src="https://github.com/EricGFigueroa/002-DailyUI-Gucci-Checkout/blob/master/img/gucci-bag-1.png?raw=true" style="width:100%">
          </div>

          <div class="productSlides fade">
            <img src="https://github.com/EricGFigueroa/002-DailyUI-Gucci-Checkout/blob/master/img/gucci-bag-2.png?raw=true" style="width:100%">
          </div>

          <div class="productSlides fade">
            <img src="https://github.com/EricGFigueroa/002-DailyUI-Gucci-Checkout/blob/master/img/gucci-bag-3.png?raw=true" style="width:100%">
          </div>

          <div class="productSlides fade">
            <img src="https://github.com/EricGFigueroa/002-DailyUI-Gucci-Checkout/blob/master/img/gucci-bag-4.png?raw=true" style="width:100%">
          </div>

          <div class="productSlides fade">
            <img src="https://github.com/EricGFigueroa/002-DailyUI-Gucci-Checkout/blob/master/img/gucci-bag-5.png?raw=true" style="width:100%">
          </div>

          <br>

          <!-- The dots/circles -->
          <div style="text-align:center">
            <span class="dot" onclick="currentSlide(1)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
            <span class="dot" onclick="currentSlide(3)"></span>
            <span class="dot" onclick="currentSlide(4)"></span>
            <span class="dot" onclick="currentSlide(5)"></span>
          </div>

        </div>

        <h1 class="product-name">
          Gucci Tian GG<br>Supreme Backpack
        </h1>
        <p class="product-code-name">
          Style 8027 K0LCN 8685
        </p>
        <p class="product-price">
          $1,590
        </p>

      </div>

      <div class="round-shape"></div>
    </div>
    <div class="modal-info">
      <div class="info">
        <h2>Payment Information</h2>
        <form action="#">
          <ul class="form-list">
            <li class="form-list-row">
              <div class="user">
                <label for="#">Name</label><br>
                <i class="fas fa-user"></i></i><input type="text" required>
              </div>
            </li>
            <li class="form-list-row">
              <div class="number">
                <label for="#">Card Number</label><br>
                <i class="far fa-credit-card"></i><input type="text" required>
              </div>
            </li>
            <li class="form-list-row clearfix">
              <div class="date">
                <label for="#">Expiration Date</label><br>
                <input class="month" type="text" required placeholder="MM">
                <input class="year" type="text" required placeholder="YY">
              </div>
              <div class="cvc">
                <label for="#">CVC</label><i class="fas fa-question-circle"></i><br>
                <input type="text" required placeholder="123">
              </div>
            </li>
            <li class="form-list-row">
              <div class="checkbox">
                <label for="checkbox">
                  <input id="checkbox" type="checkbox">
                  <span>Remember My Information</span>
                </label>
              </div>
            </li>
          </ul>
          <button>Pay Now</button>
        </form>
      </div>
    </div>
  </div>




			



		<!-- fin -->
		</seccion> 



			<?= $result['ar_name']; ?>
		   

			

		
		
		

	</div>
</main>

<?php
require_once 'includes/footer.php';
?>