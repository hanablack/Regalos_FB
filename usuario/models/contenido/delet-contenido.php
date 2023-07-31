<?php

require_once '../../../includes/conexion.php';

if($_POST) {
    $id_articulo = $_POST['id_articulo'];

    $sql_update = "DELETE FROM articulo WHERE ar_id = ?";
    $query_update = $pdo->prepare($sql_update);
    $result = $query_update->execute(array($id_articulo));
    
    if($result){
       /* if($result['ar_img_name'] != ''){
            unlink($result['ar_img_name']);
        }*/
        $arrResponse = array('status' => true, 'msg' => 'Eliminado Correctamente');
    }else{
        $arrResponse = array('status' => false, 'msg' => 'Error al Eliminar');
        
    }	
    echo json_encode($arrResponse,JSON_UNESCAPED_UNICODE);
}