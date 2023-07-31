
<!-- MODAL Regalo -->

<div class="modal fade" id="modalRegalo" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" style="max-width: 700px">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="tituloModal">Nueva Obsequio</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body" style="padding: 0px">
                <!-- document.querySelector("#id_articulo").value = data.data.ar_id;
                  document.querySelector("#titulo").value = data.data.ar_name;
                  document.querySelector("#descripcion").value = data.data.ar_description;
                  document.querySelector("#precio").value = data.data.ar_price;
                  document.querySelector("#ubicacion").value = data.data.ar_place;
                  document.querySelector("#url").value = data.data.ar_place_link; -->

                <div class="col-md-12 border p-4 bg-light">
                    <div class="card m-0 shadow" >
                        <div style="height: 65%;display: flex;align-items: center;justify-content: center;">
                            <img id="previewImage" style="object-fit: cover; width: 100%;height: 100%;"
                                src="" class="card-img-top-model" alt="">
                        </div>
                        <div style="margin: 10px">
                            <h3 class="title" id="titulo"></h3><br/>
                            <p id="descripcion"> </p>

                            <div class="input-group-prepend pb-2">
                                <div class="input-group-text "><b id="precio" class="fas fa-dollar-sign"> </b></div>

                                <a id="link" target="_blank" class="btn btn-primary"><i id="ubicacion" class="fas fa-search"> </i> </a>
                            </div>

                            <p>
                                <a id="id_articulo" href="" class="btn btn-warning btn-block px-3 waves-effect waves-light" type="button" > 
                                    <i class="fas fa-solid fa-eye" aria-hidden="true"></i> 
                                </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>