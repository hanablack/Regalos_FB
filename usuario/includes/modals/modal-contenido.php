<!-- MODAL CONTENIDO -->

<div class="modal fade" id="modalContenido" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="tituloModal">Nueva Obsequio</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="formContenido" name="formContenido" enctype="multipart/form-data">
        <input type="hidden" name="id_articulo" id="id_articulo" value="">
		<!-- <input type="hidden" name="idcurso" id="idcurso" value="   > ?= $curso; ?>"--> 
		<input type="hidden" name="idcurso" id="idcurso" value="1">
          <div class="form-group">
            <label for="control-label">Nombre del Articulo</label>
            <input type="text" class="form-control" name="titulo" id="titulo">
          </div>
		  
		  
           <div class="form-group">
            <label for="control-label">Descripcion</label>
                <textarea name="descripcion" class="form-control" id="descripcion" rows="4" ></textarea>
          </div>
          
          <div class="form-group">
            <label for="control-label">Precio</label>
            <input type="text" class="form-control" name="precio" id="precio">
          </div>

          <div class="form-group">
            <label for="control-label">Ubicacion</label>
            <input type="text" class="form-control" name="ubicacion" id="ubicacion">
          </div>

          <div class="form-group">
            <label for="control-label">link</label>
            <input type="text" class="form-control" name="url" id="url">
          </div>

		      <div class="form-group">
              <img style="width:100px" id="previewImage" src="" alt="Ninguna foto seleccionada" >
              <!-- ./images/ -->
          </div> 
          
		      <div class="form-group">
            <label for="control-label">Adjuntar foto</label>
            <input type="file" class="form-control" name="file" alt="nnhoa" id="file">
          </div>
		  
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
            <button class="btn btn-primary" id="action" type="submit">Guardar</button>
        </div>
        </form>
      </div>
    </div>
  </div>
</div>