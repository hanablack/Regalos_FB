<?php

require_once '../includes/conexion.php';

    $idusuario=$_SESSION['id_usuario'];
    #$sql = " call mis_grupos($idusuario)";
    $sql = "SELECT * FROM lista WHERE li_user = $idusuario";
    $query = $pdo->prepare($sql);
    $query->execute();
    $row = $query->rowCount();
?> 
 		
 <!-- Sidebar menu-->
 <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
    <aside class="app-sidebar">
      <div class="app-sidebar__user"><img class="app-sidebar__user-avatar" src="images/robot.png"  alt="User Image">
        <div>
          <p class="app-sidebar__user-name"><?= $_SESSION['nombre']; ?></p>
          <p class="app-sidebar__user-designation">USUARIOs  </p>
        </div>
      </div>
      <ul class="app-menu">
	  
	 <li><a class="app-menu__item" href="index.php"><i class="app-menu__icon fas fa-home"></i><span class="app-menu__label">Inicio</span></a></li>
      
	  
	  <li class="treeview">
	  <a class="app-menu__item" href="#" data-toggle="treeview">
	  <i class="app-menu__icon fa fa-laptop"></i>
	    <span class="app-menu__label">Mis Listas</span>
		<i class="treeview-indicator fa fa-angle-right"></i>
		</a>
		
		<ul class="treeview-menu">
	 <?php if($row > 0){
			while($data = $query->fetch()){
		
		?>
        <li><a class="treeview-item" href="contenido.php?lista=<?= $data['li_id'] ?>&nlista=<?= $data['li_name'] ?>"><i class="icon fa fa-circle-o"></i><?= $data['li_name']; ?></a> </li>	
	 <?php }} ?>
	 
	  
	 </ul>
	
	 </li> 
	  
	  
        <li><a class="app-menu__item" href="../logout.php"><i class="app-menu__icon fas fa-sign-out-alt"></i><span class="app-menu__label">Logout</span></a></li>
      </ul>
    </aside>