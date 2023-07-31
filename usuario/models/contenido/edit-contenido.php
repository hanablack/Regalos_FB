<?php

require '../../../includes/conexion.php';

    
if(!empty($_GET)) {
    $id_articulo = $_GET['id_articulo'];

    
    $sql = "SELECT * FROM articulo WHERE ar_id = ?";
    $query = $pdo->prepare($sql);
    $query->execute(array($id_articulo));
    $result = $query->fetch(PDO::FETCH_ASSOC);

    if(empty($result)) {
        $respuesta = array('status' => false,'msg' => 'datos no encontrados');
    } else {
       
        $respuesta = array('status' => true,'data' => $result);
    }
    echo json_encode($respuesta,JSON_UNESCAPED_UNICODE);
	
}