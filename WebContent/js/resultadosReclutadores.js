/**
 * 
 */
var oTable;		
var idCandidato;
var admin;
var aPos;
var aData;
var red=0;

$(document).ready(function(){
	
	$('#resultados').dataTable({
		"bPaginate": true,
		"sPaginateType":"full_numbers",
		"oLanguage":{
			"sSearch":"Buscar:",
			"sEmptyTable":"No se encontraron reclutadores registrados",
			"sLengthMenu": 'Mostrar <select>'+
		      '<option value="10">10</option>'+
		      '<option value="20">20</option>'+
		      '<option value="30">30</option>'+
		      '<option value="40">40</option>'+
			  '<option value="50">50</option>'+
			  '<option value="-1">All</option>'+
			  '</select> registros',
			  "oPaginate":
			  {
				  "sNext": "Siguiente",
				  "sPrevious": "Anterior"
			  },
		"sInfoFiltered": " - resultados de  _MAX_ ",
		"sInfo": "Mostrando _TOTAL_ de _END_ resultados"
		},
		"aoColumns": [
              { "mDataProp": "Nombre",	"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "Paterno", "sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "Materno", "sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "Usuario", "sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "Permisos", "sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "Pas", "sType": "string", "bVisible": false, "bSearchable": false },
              { "mDataProp": "id_candidato", "sType": "string", "bVisible": false, "bSearchable": false }
              ],
		"aaSorting":[[0,"asc"]],
		"bInfo": true,
		"bAutoWidth": true,
		"bLengthChange": true,
		"bFilter": true,
		"bSort": true
	});

	/* Seleccionar un registro*/
	$("#resultados tbody").delegate("tr", "click", function(){
		
		if ($(event.target.parentNode).hasClass('row_selected') ) {
			$(event.target.parentNode).removeClass('row_selected');
			idCandidato=0;
		}else 
		{
			oTable.$('tr.row_selected').removeClass('row_selected');
			$(event.target.parentNode).addClass('row_selected');
		}

		aPos = oTable.fnGetPosition( this );
        aData = oTable.fnGetData( aPos[0] );
        idCandidato = aData[aPos].id_candidato;		        
        $("#nombre").val(aData[aPos].Nombre);
        $("#paterno").val(aData[aPos].Paterno);
        $("#materno").val(aData[aPos].Materno);
        $("#user").val(aData[aPos].Usuario);
        $("#pass").val(aData[aPos].Pas);
        admin = aData[aPos].Permisos;
       /* if ( $(this).hasClass('row_selected') ) {
			$(this).removeClass('row_selected');
			idCandidato=0;
			aData=null;
			aPos=0;
		}
		else {
			oTable.$('tr.row_selected').removeClass('row_selected');
			$(this).addClass('row_selected');
		}*/
    });
	
	/* Retorna el objeto seleccionado*/
	function fnGetSelected( oTableLocal )
	{
		return oTableLocal.$('tr.row_selected');
	}
	
	/* Inicializar tabla */
	oTable = $('#resultados').dataTable( );

	/* Ventana para Editar registro seleccionado */
	$('#editar').click( function() {
		$('.error').remove();
		$('.checkImg').remove();
		if(aData != null)
			idCandidato = aData[aPos].id_candidato;
		else
			idCandidato = 0;
		if(idCandidato>0)
			{
			$("#nombre").val(aData[aPos].Nombre);
		     $("#paterno").val(aData[aPos].Paterno);
		     $("#materno").val(aData[aPos].Materno);
		     $("#user").val(aData[aPos].Usuario);
		     $("#pass").val(aData[aPos].Pas);
		     admin = aData[aPos].Permisos;
			 var editarCandidato = document.getElementById("editarReclutador");
		     dimmer = document.createElement("div");
			 dimmer.style.width =  window.innerWidth + 'px';
			 dimmer.style.height = window.innerHeight + 'px';
			 dimmer.className = 'dimmer';
			 if(admin=="Administrador")
				 document.getElementById("Admin").checked = true;
			 else
				 document.getElementById("Admin").checked = false;
			 dimmer.onclick = function()
			 {
				 document.body.removeChild(this);   
			     editarCandidato.style.visibility = 'hidden';
			 };
		        document.body.appendChild(dimmer);
				 editarCandidato.style.visibility = 'visible';
			 return false;
			}
		else{ 
			ventanaError("Error: Por favor, seleccione un registro dando click sobre alguna de las celdas.",1);
			}
	} );
	
	/* Envío o servlet para editar registro*/
	$('#btnEditar').click( function() {
		$('.error').remove(); 
		if(		validarNombre($('#nombre').val()) &&
				validarApellido($('#paterno').val()) &&
				validarUsuario($('#user').val()) &&
				validarPassword($('#pass').val())  )
			{
				if($("#materno").val()!='')
				{
					if(validarApellido($("#materno").val()))
						enviarEdicionReclutador();
					else
						$('#validacion').append('<p class="error">Error al guardar los datos, por favor verifique la información</p>');
				}else
					enviarEdicionReclutador();
			}else
				$('#validacion').append('<p class="error">Error al guardar los datos, por favor verifique la información</p>');		     
	} );
	
	/* Eliminar registro seleccionado*/
	$('#eliminar').click( function() {
		if(idCandidato>0)
		{
			var seguroEliminar = document.getElementById("seguroEliminar");
			dimmerError = document.createElement("div");
			dimmerError.style.width =  window.innerWidth + 'px';
			dimmerError.style.height = window.innerHeight + 'px';
			dimmerError.className = 'dimmerError';
			dimmerError.onclick = function()
			 {
				document.body.removeChild(this);   
				seguroEliminar.style.visibility = 'hidden';
				$("#info").removeAttr("p");
				$("#info").html('');
			 };
			 document.body.appendChild(dimmerError);
			 seguroEliminar.style.visibility = 'visible';
			return false;
		}else{
			ventanaError("Error: Por favor, seleccione un registro dando click sobre alguna de las celdas.",1);
			}
	});
	
	/*Envia la ediciòn del reclutador*/
	function enviarEdicionReclutador()
	{
		var admin = 0;
		if( document.getElementById("Admin").checked)
			admin =1;
		$.ajax({
			url:'/Aplicacion1.3/editarReclutador',
			type:'POST',
			data:'idReclutador=' + idCandidato +
			'&nombre=' + $("#nombre").val() +
			'&apeMaterno='+ $("#materno").val() +
			'&apePaterno='+ $("#paterno").val() +
			'&pass='+ $("#pass").val() +
			'&user='+ $("#user").val() + 
			'&admin=' + admin,
			success: function(resultado) {
				cerrarVentanaEdicion();
				ventanaError(resultado,0);
		        red=1;
				}
		});//fin .ajax()
	}
	
	/* Dialogo de confirmación para la acción eliminar*/
	$('#siQuieroEliminar').click( function() {
		document.body.removeChild(dimmerError);   
		seguroEliminar.style.visibility = 'hidden';
		if(idCandidato>0)
		{
			$.ajax({
				url:'/Aplicacion1.3/eliminarReclutador',
				type: 'POST',
				data:'idReclutador=' + idCandidato,
				success: function(data,  textStatus, jqXHR) {
					ventanaErrorReclutadores( jqXHR.responseText, 0);
					red=1;
					setTimeOut(function(){
							window.location.href='MostrarReclutadores.jsp';
							},2000);
						},
				error:function(jqXHR, textStatus, errorThrown){
						if(jqXHR.responseText != '')
							ventanaErrorReclutadores("Error: " + jqXHR.responseText, 1);
						else
							ventanaError("Error: El reclutador no se ha podido eliminar poque tiene candidatos registrados", 1);
						}
			});//fin .ajax()
			return false;
		}
		else
			ventanaErrorReclutadores("Por favor seleccione un registro, realizando click sobre alguna de las celdas", 1);
	} );
	
	function ventanaErrorReclutadores(text , e)
	{	
		var error = document.getElementById("ventana");
		dimmerError = document.createElement("div");
		if(e == 1)
			$('#info').append('<p class="error">'+ text +'</p>');
		else
			$('#info').append('<p class="info">'+ text +'</p>');
		dimmerError.style.width =  window.innerWidth + 'px';
		dimmerError.style.height = window.innerHeight + 'px';
		dimmerError.className = 'dimmerError';			
		dimmerError.onclick = function()
		 {
			 document.body.removeChild(this);   
			 error.style.visibility = 'hidden';
			 $("#info").removeAttr("p");
			 $("#info").html('');
			 window.location.href='MostrarReclutadores.jsp';
		 };
		document.body.appendChild(dimmerError);
		error.style.visibility = 'visible';
		return false;
	}
	
	/* Cierre de diálogo */
	$('#noQuieroEliminar').click( function() {
		document.body.removeChild(dimmerError);   
		seguroEliminar.style.visibility = 'hidden';
	} );
	
	/*Cancelar la edicion del reclutador*/
	$('#btnCancelar').click(function()
	{
		cerrarVentanaEdicion();
	});
		
	/*Cierra ventana de edición de los datos del reclutador*/
	function cerrarVentanaEdicion()
	{
		var editarCandidato = document.getElementById("editarReclutador");
		editarCandidato.style.visibility = 'hidden';
		document.body.removeChild(dimmer);
		if(red==1)
			window.location.reload();
	}
	
	/*Indica que hubo error al eliminar*/
	function ventanaErrorEliminar(text , e)
	{	
		var error = document.getElementById("ventana");
		dimmerError = document.createElement("div");
		if(e == 1)
			$('#info').append('<p class="error">'+ text +'</p>');
		else
			$('#info').append('<p class="info">'+ text +'</p>');
		dimmerError.style.width =  window.innerWidth + 'px';
		dimmerError.style.height = window.innerHeight + 'px';
		dimmerError.className = 'dimmerError';			
		document.body.appendChild(dimmerError);
		error.style.visibility = 'visible';
		return false;
	}
	
	function ventanaError(text , e)
	{	
		var error = document.getElementById("ventana");
		dimmerError = document.createElement("div");
		if(e == 1)
			$('#info').append('<p class="error">'+ text +'</p>');
		else
			$('#info').append('<p class="info">'+ text +'</p>');
		dimmerError.style.width =  window.innerWidth + 'px';
		dimmerError.style.height = window.innerHeight + 'px';
		dimmerError.className = 'dimmerError';			
		dimmerError.onclick = function()
		 {
			error.style.visibility = 'hidden';
			document.body.removeChild(dimmerError);
			$("#info").html('');
		 };
		 document.body.appendChild(dimmerError);
		 error.style.visibility = 'visible';
		return false;
	}
	
	$('#btnCerrarVentanaError').click(function(){
		var error = document.getElementById("ventana");
		error.style.visibility = 'hidden';
		document.body.removeChild(dimmerError);
		$("#info").html('');
		if(red==1)
			window.location.href='MostrarReclutadores.jsp';
		red=0;
	});

});	//end function