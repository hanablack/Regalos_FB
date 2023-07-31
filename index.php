<?php

if(!empty($_SESSION['active'])) {
    header('Location: administrador/');
} else if(!empty($_SESSION['activeP'])) {
    header('Location: usuario/');
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>INGRESO AL SISTEMA</title>
</head>
<body>
<header class="main-header">

        <div class="main-cont">
            <div class="desc-header">
                <img src="images/school1.svg" alt="image school">
                <p>Sistema de Gestión Escolar </p>
            </div>
        </div>
        <div class="cont-header">
            <h2>Bienvenidos </h2>

                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <!--<li class="nav-item" role="presentation">
                        <a class="nav-link " id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Administrador</a>
                    </li>-->
                    <li class="nav-item" role="presentation">
                        <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Usuario</a>
                    </li>
                </ul>

                <div class="tab-content" id="myTabContent">
                  <!--  <div class="tab-pane fade " id="home" role="tabpanel" aria-labelledby="home-tab">
                        <form action="" onsubmit="return validar()">
                            <label for="usuario">Usuario</label>
                            <input type="text" name="usuario" id="usuario" placeholder="Nombre de usuario">
                            <label for="password">Contraseña</label>
                            <input type="password" name="pass" id="pass" placeholder="Contraseña">
                            <div id="messageUsuario"></div>
                            <button id="loginUsuario" type="button">INICIAR SESION</button>
                        </form>
                    </div> -->
                    <div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                        <form action="" onsubmit="return validar()">
                            <label for="usuario">Usuario usuario</label>
                            <input type="text" name="usuarioUsuario" id="usuarioUsuario" placeholder="Nombre de usuario">
                            <label for="password">Contraseña</label>
                            <input type="password" name="passUsuario" id="passUsuario" placeholder="Contraseña">
                            <div id="messageUsuario"></div>
                            <button id="loginUsuario" type="button">INICIAR SESIONN </button>
                        </form>
                    </div>
                </div>
        </div>

</header>

<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/login.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
