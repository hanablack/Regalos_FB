document.addEventListener("DOMContentLoaded", function () {
  var formContenido = document.querySelector("#formContenido");
  formContenido.onsubmit = function (e) {
    e.preventDefault();

    var id_articulo = document.querySelector("#id_articulo").value;
    var titulo = document.querySelector("#titulo").value;
    var descripcion = document.querySelector("#descripcion").value;
    var precio = document.querySelector("#precio").value;
    var material = document.querySelector("#file").value;

    if (titulo == "" || descripcion == "" || precio == "") {
      swal("Atencion", "Todos los campos son necesarioss22", "error");
      return false;
    }
    if (!precio || isNaN(precio)) {
      swal("Atencion", "Error en el monto del precio", "error");
      return false;
    }

    var request = window.XMLHttpRequest
      ? new XMLHttpRequest()
      : new ActiveXObject("Microsoft.XMLHTTP");
    var url = "./models/contenido/ajax-contenido.php";
    var form = new FormData(formContenido);
    request.open("POST", url, true);
    request.send(form);
    request.onreadystatechange = function () {
      if (request.readyState == 4 && request.status == 200) {
        var data = JSON.parse(request.responseText);
        swal(
          {
            title: "Crear/Actualizar Contenido",
            type: "success",
            confirmButtonText: "Aceptar",
            closeOnConfirm: true,
          },
          function (confirm) {
            if (confirm) {
              if (data.status) {
                $("#modalContenido").modal("hide");
                location.reload();
                formContenido.reset();
              } else {
                swal("Atencion", data.msg, "error");
              }
            }
          }
        );
      }
    };
  };
});

function openModalContenido() {
  document.querySelector("#id_articulo").value = 0;
  document.querySelector("#previewImage").src = "";
  document.querySelector("#tituloModal").innerHTML = "Nuevo Contenido";
  document.querySelector("#action").innerHTML = "Guardar";
  document.querySelector("#formContenido").reset();
  $("#modalContenido").modal("show");
}

function openRegalo(id) {
  var id_articulo = id;

  document.querySelector("#tituloModal").innerHTML = "Actualizar Contenidos";
  //document.querySelector("#action").innerHTML = "Actualizar";

  var request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
    var url_ = "./models/contenido/edit-contenido.php?id_articulo=" + id_articulo;

  request.open("GET", url_, true);
  request.send();
  
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      var data = JSON.parse(request.responseText);
      
      if (data.status) {
        
        document.querySelector("#id_articulo").textContent = "Regalar - "+data.data.ar_id;
        document.querySelector("#id_articulo").href = "pago.php?articulo="+data.data.ar_id; 

        document.querySelector("#titulo").textContent = data.data.ar_name;
       document.querySelector("#descripcion").textContent = data.data.ar_description;
      document.querySelector("#precio").textContent = data.data.ar_price;

       if (isValidURL(data.data.ar_place_link)) {
        document.querySelector("#link").href = data.data.ar_place_link;
        console.log("link validos");
      } 
      else{
        document.querySelector("#link").removeAttribute("href");
        console.log("link no valido");
       }

      document.querySelector("#ubicacion").innerHTML = "  "+data.data.ar_place;
         

        if (data.data.ar_img_name !== null &&  data.data.ar_img_name !== undefined  ) {
          document.querySelector("#previewImage").alt = data.data.ar_img_name;
          document.querySelector("#previewImage").src = data.data.ar_path.replace("../../","");
          // <?= str_replace("../../../","../",$data['ar_path']); ?>
          
        }

        $("#modalRegalo").modal("show");
      } else {
        swal("Atencion", data.msg, "error");
      }
    }
  };
}



function editarContenido(id) {
  var id_articulo = id;

  document.querySelector("#tituloModal").innerHTML = "Actualizar Contenidos";
  document.querySelector("#action").innerHTML = "Actualizar";

  var request = window.XMLHttpRequest
    ? new XMLHttpRequest()
    : new ActiveXObject("Microsoft.XMLHTTP");
    var url_ = "./models/contenido/edit-contenido.php?id_articulo=" + id_articulo;

  request.open("GET", url_, true);
  request.send();
  
  request.onreadystatechange = function () {
    if (request.readyState == 4 && request.status == 200) {
      var data = JSON.parse(request.responseText);
      
      if (data.status) {
        console.log(id_articulo + " holas2");
        document.querySelector("#id_articulo").value = data.data.ar_id;
        document.querySelector("#titulo").value = data.data.ar_name;
        document.querySelector("#descripcion").value = data.data.ar_description;
        document.querySelector("#precio").value = data.data.ar_price;
        document.querySelector("#ubicacion").value = data.data.ar_place;
        document.querySelector("#url").value = data.data.ar_place_link;

        if (data.data.ar_img_name !== null &&  data.data.ar_img_name !== undefined  ) {
          //document.querySelector("#previewImage").alt = data.data.ar_img_name;
          document.querySelector("#previewImage").src = data.data.ar_path.replace("../../","");
          
        }

        $("#modalContenido").modal("show");
      } else {
        swal("Atencion", data.msg, "error");
      }
    }
  };
}

function eliminarContenido(id) {
  var id_articulo = id;

  swal(
    {
      title: "Eliminar Contenidos",
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "Si, eliminar",
      cancelButtonText: "No, cancelar",
      closeOnConfirm: false,
      closeOnCancel: true,
    },
    function (confirm) {
      if (confirm) {
        var request = window.XMLHttpRequest
          ? new XMLHttpRequest()
          : new ActiveXObject("Microsoft.XMLHTTP");
        var url = "./models/contenido/delet-contenido.php";
        request.open("POST", url, true);
     

        var strData = "id_articulo=" + id_articulo;
        request.setRequestHeader(
          "Content-type",
          "application/x-www-form-urlencoded"
        );
        request.send(strData);
        request.onreadystatechange = function () {
          if (request.readyState == 4 && request.status == 200) {
            var data = JSON.parse(request.responseText);
            
            if (data.status) {
              location.reload();
            } else {
              swal("Atencion", data.msg, "error");
            }
          }
        };
      }
    }
  );
}


function isValidURL(url) {
  try {
    new URL(url);
    return true;
  } catch (error) {
    return false;
  }
}