<?php

require_once '../../../includes/conexion.php';

if(!empty($_POST)) {
	if(empty($_POST['titulo']) || empty($_POST['descripcion']) || empty($_POST['precio'])) {
		$respuesta = array('status' => false,'msg' => 'Todos loss campos son necesarios');
	}else if (!isset($_POST['precio']) || !is_numeric($_POST['precio'])) {
        $respuesta = array('status' => false,'msg' => 'Error en el monto del precio');
    }else{

        //session_start();   

        $id = $_POST['id_articulo'];
        $name = $_POST['titulo'];
        $price = $_POST['precio'];
        $place = $_POST['ubicacion'];
        $place_link = $_POST['url'];
		$description = $_POST['descripcion'];
		
		
		$img_name = $_FILES['file']['name'];
		$type = $_FILES['file']['type'];
		$url_temp = $_FILES['file']['tmp_name'];
		
		
		$directorio = '../../../uploads/'.rand(1000,10000);
		if(!file_exists($directorio)){
			mkdir($directorio, 0777, true);
		}
		
		$path = $directorio.'/'.$img_name;
		
		$sql = "SELECT * FROM articulo WHERE ar_id = ?";   
        $query = $pdo->prepare($sql);
        $query->execute(array($id));
        $data = $query->fetch(PDO::FETCH_ASSOC);
		
		if($_FILES['file']['size'] > 15000000) {
            $respuesta = array('status' => false,'msg' => 'Solo se permiten archivos hasta 15mb');
        } else {
            if(!empty($data['ar_img_name'])){
                if(empty($_FILES['file']['name'])){
                    $path = $data['ar_path'];
                    $img_name = $data['ar_img_name'];
                    
                }else{
                    if($data['ar_path'] != ''){
                        unlink($data['ar_path']);
                    }
                }
            }
            
            
            $sqlInsert = 'CALL actualizar_articulo(?, ?, ?, ?, ?, ?, ?, ?,?);';
            $queryInsert = $pdo->prepare($sqlInsert);
            $request = $queryInsert->execute(array($id,1,$name,$description,$price,$place,$place_link,$img_name,$path));
            move_uploaded_file($url_temp,$path);
          
                /*
            if($id == 0) {
                //el primer 1 es el id de la lista
                $sqlInsert = 'CALL InsertarArticulo(1, ?, ?, ?, ?, ?, ?, ?, 1);';
                $queryInsert = $pdo->prepare($sqlInsert);
                $request = $queryInsert->execute(array($name,$descripcion,$price,$path,$img_name,$place,$url));
                    move_uploaded_file($url_temp,$path);
                $accion = 1;    
            } else {
				if(empty($_FILES['file']['name'])){
                    //no usa id de lista 
                    $sqlUpdate = 'CALL ModificarArticulo(?, ?, ?, ?, ?, ?, ?, ?, 1);';
                    $queryUpdate = $pdo->prepare($sqlUpdate);
                    $request = $queryUpdate->execute(array($id,$name,$descripcion,$price,$data['path'],$data['photo'],$place,$url));
                    $accion = 2;
                } else{
                    $sqlUpdate = 'CALL ModificarArticulo(?, ?, ?, ?, ?, ?, ?, ?, 1);';
                   
                    $queryUpdate = $pdo->prepare($sqlUpdate);
                    $request = $queryUpdate->execute(array($id,$name,$descripcion,$price,$path,$img_name,$place,$url));
                    if($data['path'] != ''){
                        unlink($data['path']);
                    }
                    move_uploaded_file($url_temp,$path);
                    $accion = 3;
                }
            }*/
        }

        if($request > 0) {
            if($id == 0) {
                $respuesta = array('status' => true,'msg' => 'Actividad creada correctamente');
            } else {
                $respuesta = array('status' => true,'msg' => 'Actividad actualizada correctamente');
            }
        }
    }

    echo json_encode($respuesta,JSON_UNESCAPED_UNICODE);
}