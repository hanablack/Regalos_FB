<?php

require_once '../includes/conexion.php';  
require_once 'includes/header.php';
require_once 'includes/modals/modals.php';

	
if(!empty($_GET['lista'])){
	$id_lista = $_GET['lista'];
	$_SESSION['lista'] = $id_lista;

 }else{
	header("Location: usuario/");
 }

 if(!empty($_GET['nlista'])){
	$nlista = $_GET['nlista'];
	$_SESSION['nlista'] = $nlista;

 }else{
	header("Location: usuario/");
 }


    $idusuario=$_SESSION['id_usuario'];		
	$_SESSION['rol_']= 0 ; 

	#$sql = "call mis_grupos($idusuario)";
    $sql = 'SELECT * FROM articulo where ar_list = ?';
    $query = $pdo->prepare($sql);
    $query->execute(array($id_lista));
    $row = $query->rowCount();
	consola($idusuario."hola". $id_lista );
?>
<main class="app-content">
  <div class="row">
    <div class="col-md-12 text-center border shadow p-2 bg-info text-white">
      <h3 class="display-4"><?= $_SESSION['nombre'] ?></h3>
    </div>
  </div>

 
    <div class="col-md-12 text-center border mt-3 p-4 bg-light">
      <h4><?= $nlista ?></h4>
    </div> 

  <div class="row">
    <?php if($row > 0){
      while($data = $query->fetch()){ 
    ?>

	<div class="col-md-4 border mt-3 p-4 bg-light">	
		<div class="card m-0 shadow" >
			<div style="height: 65% ;display: flex; align-items: center; justify-content: center;">
				<img style="object-fit: cover; width: 100%"src="<?= str_replace("../../../","../",$data['ar_path']); ?>" class="card-img-top" alt="<?= $data['ar_path']; ?>">

			</div>
			<div style="margin:10px">
				<h3 class="title"><?= $data['ar_name']; ?></h3>
				
				<b><?= $data['ar_price']; ?>$</b>        
				<p>
					<button class="btn btn-warning btn-block px-3 waves-effect waves-light" type="button" onclick="openRegalo(<?= $data['ar_id']; ?>)">
						<i class="fas fa-solid fa-eye" aria-hidden="true"></i> Ver - <?= $data['ar_id']; ?>
					</button>
				</p>
			</div>
		</div>
	</div>

    <?php }}
    else{
      consola('no hay nada');
    } ?>
  </div>
  <div class="row">
	         <a href="index.php" class="btn btn-info">Volver Atras</a>
	    </div>
</main>


<?php
require_once 'includes/footer.php';
?>