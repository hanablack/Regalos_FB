<?php

require_once '../includes/conexion.php';  
require_once 'includes/header.php';


    $idusuario=$_SESSION['id_usuario'];		
	$_SESSION['rol_']= 0 ; 

	#$sql = "call mis_grupos($idusuario)";
    $sql = 'SELECT * FROM lista WHERE li_user = ?';
    $query = $pdo->prepare($sql);
    $query->execute(array($idusuario));
    $row = $query->rowCount();
	consola($idusuario);
?>

<main class="app-content">
      <div class="row">
	    <div class="col-md-12 text-center  border shadow p-2 bg-info text-white">
		    <h3 class="display-4"><?= $_SESSION['nombre']; ?> </h3>
	  </div>
	  </div>
	  <div class="row">	
	    <div class="col-md-12 text-center border mt-3 p-4 bg-light">
		    <h4>MIS Listas</h4>
		</div> 
	    </div>
	  
	  <div class="row">
	    <?php if($row > 0){
			while($data = $query->fetch()){
		?>
		<div class="col-md-4 text-center border mt-3 p-4 bg-light" style="max-width: 25rem;">
		    <div class="card m-2 shadow" >
			    <img src="images/card-school.jpg" class="card-img-top" alt="..." >
				<div class="card-body">
				    <h4 class="card-title text-center"><?= $data['li_name']; ?></h4>
				
					<a href="contenido.php?lista=<?= $data['li_id'] ?>&nlista=<?= $data['li_name'] ?>" class="btn btn-primary">Acceder</a>
					<a href="lista.php?lista=<?= $data['li_id'] ?>&nlista=<?= $data['li_name']?>" class="btn btn-warning">Ver</a>

				</div>
			
			</div>
		
		</div>
		<?php }}
		else{
			consola('no hay nada');
		}
		?>
		
		
	  </div>
	  
    </main>

<?php
require_once 'includes/footer.php';
?>