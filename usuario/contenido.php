<?php



/*
if(!empty($_GET['curso'])){
	$curso = $_GET['curso'];
}else{
	header("Location: usuario/");
	
}*/
    require_once 'includes/header.php'; 	 		
	  require_once '../includes/conexion.php';
    require_once 'includes/modals/modal-contenido.php';
	
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
	 
    #$sql = "call mi_contenido($id_lista)";
	
	$sql = 'SELECT * FROM articulo where ar_list = ?';
    $query = $pdo->prepare($sql);
    $query->execute(array($id_lista));
    $row = $query->rowCount();
	consola($id_lista);
	 
?>

<main class="app-content">
  <div class="app-title">
    <div>
      <h1>
        <i class="app-menu__icon fa fa-user-graduate"></i>
        <?= $nlista; ?>	
        <button class="btn btn-success" type="button" onclick="openModalContenido()">Nuevo</button>
      </h1>
    </div>
    <ul class="app-breadcrumb breadcrumb">
      <li class="breadcrumb-item"><i class="fa fa-home fa-lg"></i></li>
      <li class="breadcrumb-item"><a href="#"><?= $nlista; ?></a></li>
    </ul>
  </div>
  
  <div class="row">
    <?php if ($row > 0) {
      while ($data = $query->fetch()) {
    ?>
      <div class="col-md-12">
        <div class="tile">
          <div class="tile-title-w-btn">
            <h3 class="title"><?= $data['ar_name']; ?></h3>
            <div>
              <button class="btn btn-info icon-btn" onclick="editarContenido(<?= $data['ar_id']; ?>)">
                <i class="fa fa-edit"></i>Editar - <?= $data['ar_id']; ?>
              </button>
              <button class="btn btn-danger icon-btn" onclick="eliminarContenido(<?= $data['ar_id']; ?>)">
                <i class="fa fa-delet"></i>Eliminar
              </button> 
            </div>
          </div>

          <div class="tile-body">
            <div class="col-12">
              <img src="<?= str_replace("../../../","../",$data['ar_path']); ?>" style="display: block;width: 120px; margin-right: 10px; float: left;">
              <p style=""><?= $data['ar_description']; ?></p> 
            </div>
          </div>

          <div class="title-footer mt-4">
            <div class="input-group">
              <div class="input-group-prepend" >
                <?php
                if (filter_var($data['ar_place_link'], FILTER_VALIDATE_URL))  echo '<a href="' . $data['ar_place_link']. '" target="_blank" class="btn btn-primary"><i class="fas fa-link"></i> ' . $data['ar_place'] . '</a>';
                else  echo '<a target="_blank" class="btn btn-primary"><i class="fas fa-link"></i> ' . $data['ar_place'] . '</a>';
                ?>
                <div class="input-group-text "><b class="fas fa-dollar-sign"> <?= $data['ar_price']; ?></b></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    <?php }} ?>
  </div>

  <div class="row mt-3">
    <div class="col-md-12 text-center">
      <a href="index.php" class="btn btn-info">Volver Atras</a>
    </div>
  </div>
</main>


<?php
    require_once 'includes/footer.php';
?>