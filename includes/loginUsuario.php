<?php
session_start();
if(!empty($_POST)) {
    if(empty($_POST['loginUsuario']) || empty($_POST['passUsuario'])) {
        echo '<div class="alert alert-danger"><button type="button" class="close" data-dismiss="alert">&times;</button>Todos los campos son necesarios</div>';
    } else {
        require_once 'conexion.php';
        $login = $_POST['loginUsuario'];
        $pass = $_POST['passUsuario'];
                
        $sql = 'SELECT * FROM usuarios WHERE us_user = ?';
        $query = $pdo->prepare($sql);
        $query->execute(array($login));
        $result = $query->fetch(PDO::FETCH_ASSOC);
        
        if($query->rowCount() > 0) {
            if($pass == $result['us_pass']) {
            #if(password_verify($pass, $result['pass'])) {
                $_SESSION['activeP'] = true;
                $_SESSION['id_usuario'] = $result['us_id'];
                $_SESSION['nombre'] = $result['us_name'];
                #$_SESSION['cedula'] = $result['cedula'];

                echo '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>Redirecting</div>';
            }else {
                echo '<div class="alert alert-danger"><button type="button" class="close" data-dismiss="alert">&times;</button>Usuario o Clave incorrectos</div>';
            }
        } else {
            echo '<div class="alert alert-danger"><button type="button" class="close" data-dismiss="alert">&times;</button>UUUUsuario o Clave incorrectos</div>';
        }
    }
}
