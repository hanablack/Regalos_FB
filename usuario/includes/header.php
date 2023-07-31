<?php


function consola($data) {
	$console = $data;
	if (is_array($console))
	    $console = implode(',', $console);
   
	echo "<script>console.log('Console: " . $console . "' );</script>";
   }



  session_start();
  if(empty($_SESSION['activeP'])) {
    header('Location: ../');
  }
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="description" content="sistema escolar">
    <title>SISTEMA ESCOLAR BEHO</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <!-- Font-icon css-->
    <!--<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">-->
  </head>
  <body class="app sidebar-mini">
    <!-- Navbar-->
    <header class="app-header"><a class="app-header__logo" href="index.php">Lista de Cumpleaños</a>
      <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"> <i class="fas fa-bars"></i></a>
      <!-- Navbar Right Menu-->
      <ul class="app-nav">
        <!-- User Menu-->
		<li><a class="app-menu__item" href="gestion2/index.php"><i class="app-menu__icon fa fa-cog fa-lg"></i></i><span class="app-menu__label">Gestion Materias  </span></a></li> 
        <li class="dropdown"><a class="app-nav__item" href="#" data-toggle="dropdown" aria-label="Open Profile Menu"><i class="fa fa-user fa-lg"></i></a>
          
		  <ul class="dropdown-menu settings-menu dropdown-menu-right">
            <li><a class="dropdown-item" href="./index.php"><i class="fa fa-cog fa-lg"></i>Ajuste</a></li>
            <li><a class="dropdown-item" href="./index.php"><i class="fa fa-user fa-lg"></i> Perfil</a></li>
            <li><a class="dropdown-item" href="../logout.php"><i class="app-menu__icon fas fa-sign-out-alt"></i> Cerrar sesion</a></li>
          </ul>
        </li>
      </ul>
    </header>

    
<?php require_once 'nav.php'; ?>  