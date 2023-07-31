<?php

require_once '../../../includes/conexion.php';

if(!empty($_POST)) {
    if(empty($_POST['nombre']) || empty($_POST['direccion']) || empty($_POST['cedula']) || empty($_POST['telefono']) || empty($_POST['correo']) || empty($_POST['nivel_est'])) {
        $respuesta = array('status' => false,'msg' => 'Todos los campos son necesarios');
    } else {
        $idusuario= $_POST['idusuario'];
        $nombre = $_POST['nombre'];
        $direccion = $_POST['direccion'];
        $cedula = $_POST['cedula'];
        $telefono = $_POST['telefono'];
        $correo = $_POST['correo'];
        $nivel_est = $_POST['nivel_est'];
        $estado = $_POST['listEstado'];

        $sql = 'SELECT * FROM usuario WHERE cedula = ? AND usuario_id != ? AND estado != 0';
        $query = $pdo->prepare($sql);
        $query->execute(array($cedula,$idusuario));
        $result = $query->fetch(PDO::FETCH_ASSOC);

        if($result > 0) {
            $respuesta = array('status' => false,'msg' => 'El usuario ya existe');
        } else {
            if($idusuario== 0) {
                $clave = password_hash($_POST['clave'],PASSWORD_DEFAULT);
                $sqlInsert = 'INSERT INTO usuario (nombre,direccion,cedula,clave,telefono,correo,nivel_est,estado) VALUES (?,?,?,?,?,?,?,?)';
                $queryInsert = $pdo->prepare($sqlInsert);
                $request = $queryInsert->execute(array($nombre,$direccion,$cedula,$clave,$telefono,$correo,$nivel_est,$estado));
                $accion = 1;
            } else {
                if(empty($_POST['clave'])) {
                    $sqlUpdate = 'UPDATE usuario SET nombre = ?,direccion = ?,cedula = ?,telefono = ?,correo = ?,nivel_est = ?,estado = ? WHERE usuario_id = ?';
                    $queryUpdate = $pdo->prepare($sqlUpdate);
                    $request = $queryUpdate->execute(array($nombre,$direccion,$cedula,$telefono,$correo,$nivel_est,$estado,$idusuario));
                    $accion = 2;
                } else {
                    $claveUpdate = password_hash($_POST['clave'],PASSWORD_DEFAULT);
                    $sqlUpdate = 'UPDATE usuario SET nombre = ?,direccion = ?,cedula = ?,clave = ?,telefono = ?,correo = ?,nivel_est = ?,estado = ? WHERE usuario_id = ?';
                    $queryUpdate = $pdo->prepare($sqlUpdate);
                    $request = $queryUpdate->execute(array($nombre,$direccion,$cedula,$claveUpdate,$telefono,$correo,$nivel_est,$estado,$idusuario));
                    $accion = 3;
                }
            }  

            if($request > 0) {
                if($accion == 1) {
                    $respuesta = array('status' => true,'msg' => 'Usuario creado correctamente');
                } else {
                    $respuesta = array('status' => true,'msg' => 'Usuario actualizado correctamente');
                }
            }
        }
    }
    echo json_encode($respuesta,JSON_UNESCAPED_UNICODE);
}