/**
 * Inicialización de la tabla para mostrar los candidatos reclutados
 */

var aPos;
var dimmer;
var dimmerError;
var idCandidato=0;
var aData;
var oTable;
var oTable2;
var re = 0; /*Reload yes or no*/
var red=0;
var tablaSize;
/* Inicializar tabla */
	
$(document).ready(function(){
	
	/**Tablas**/
	
	$('#resultados').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"bPaginate": true,
		"sPaginateType":"full_numbers",
		"oLanguage":{
			"sSearch":"Buscar:",
			"sEmptyTable":"No se encontraron candidatos registrados",
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
		"sInfo": "Mostrando _END_ de _TOTAL_ resultados"
		},
		"aoColumns": [
	              { "mDataProp": "Nombre",	"sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "Paterno", "sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "Materno", "sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "curp", 	"sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "rfc", 	"sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "email", 	"sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "telefono","sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "tecnologia","sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "palabras","sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "fecha","sType": "string", "bVisible": true, "bSearchable": true },
                  { "mDataProp": "id_candidato","sType": "string", "bVisible": false, "bSearchable": false }
                 ],
     "aSorting":[[1,"asc"]],
	 "bInfo": true,
	 "bAutoWidth": true,
	 "bLengthChange": true,
	 "bFilter": true,
	 "bSort": true
	});
	
	oTable = $('#resultados').dataTable();
	
	/* Seleccionar un registro*/
	$("#resultados tbody").delegate("tr", "click", function(){
		deseleccionarTecnologias();
		if ($(event.target.parentNode).hasClass('row_selected') ) {
			$(event.target.parentNode).removeClass('row_selected');
			idCandidato=0;
		}else 
		{
			oTable.$('tr.row_selected').removeClass('row_selected');
			$(event.target.parentNode).addClass('row_selected');
			aPos = oTable.fnGetPosition( this );
			aData = oTable.fnGetData( aPos[0] );
			idCandidato = aData[aPos].id_candidato;
	        $("#nombre").val(aData[aPos].Nombre);
	        $("#paterno").val(aData[aPos].Paterno);
	        $("#materno").val(aData[aPos].Materno);
	        $("#curpEditar").val(aData[aPos].curp);
	        $("#rfc").val(aData[aPos].rfc);
	        $("#email").val(aData[aPos].email);
	        $("#telefono").val(aData[aPos].telefono);
	        $("#tecnologia").val(aData[aPos].tecnologia);
	        $("#palabras").val(aData[aPos].palabras);
	        $("#reclutador").val(aData[aPos].reclutador);
		}
    });
	
	function deseleccionarTecnologias()
	{
		$("#tecnologiaEditar input:checked").each(function() {
			$(this).prop('checked', false);
	    });
	}
	
	$('#resultados_length select').click(function(){
		resizeFrame();
	});
					
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
			 };
			 document.body.appendChild(dimmerError);
			 seguroEliminar.style.visibility = 'visible';
			return false;
		}else
			ventanaError("Error: Porfavor seleccione un registro haciendo click sobre alguna de las celdas.", 1);
	});
			
	/* Dialogo de confirmación para la acción eliminar*/
	$('#siQuieroEliminar').click( function() {
		document.body.removeChild(dimmerError);   
		seguroEliminar.style.visibility = 'hidden';
		if(idCandidato>0)
		{
			$.ajax({
				url:'/Aplicacion1.3/EliminarCandidato',
				type: 'POST',
				data: 'idCandidato=' + idCandidato,
				success: function(data,  textStatus, jqXHR) {
					re=1;
					ventanaError( jqXHR.responseText, 0);
					setTimeOut(function(){window.location.reload();},2000);
					},
				error:function(jqXHR, textStatus, errorThrown){
					if(jqXHR.responseText != '')
						ventanaError("Error: " + jqXHR.responseText, 1);
					else
						ventanaError("Error: No ha sido posible eliminar al candidato, intente nuevamente", 1);
					}
			});//fin .ajax()
			return false;
		}
		else
			ventanaError("Por favor seleccione un registro, realizando click sobre alguna de las celdas", 1);
	} );
			
	/* Cierre de diálogo */
	$('#noQuieroEliminar').click( function() {
		window.location.reload();
	} );
			
	/* Ventana para Editar registro seleccionado */
	$('#editar').click( function() {
		$('.error').remove();
		$('.validar').remove();
		/*if(aData!=null)
			idCandidato = aData[aPos].id_candidato;
		else
			idCandidato = 0; */
		var editarCandidato = document.getElementById("editarCandidato");
		if(idCandidato>0)
			{  
	        $("#nombre").val(aData[aPos].Nombre);
	        $("#paterno").val(aData[aPos].Paterno);
	        $("#materno").val(aData[aPos].Materno);
	        $("#curpEditar").val(aData[aPos].curp);
	        $("#rfc").val(aData[aPos].rfc);
	        $("#email").val(aData[aPos].email);
	        $("#telefono").val(aData[aPos].telefono);
	        $("#palabras").val(aData[aPos].palabras);
	        $("#reclutador").val(aData[aPos].reclutador);
			 
		     dimmer = document.createElement("div");
		     dimmer.style.width =  window.innerWidth + 'px';
			 dimmer.style.height = (window.innerHeight+300) + 'px';
			 dimmer.className = 'dimmer';
			 
			 obtenerTecnologiasCandidato(idCandidato);
			 checkTecnologias(tecno);
			 
				dimmer.onclick = function()
				{
					document.body.removeChild(this);
					editarCandidato.style.visibility = 'hidden';
					document.getElementById("todo").style.height = tablaSize;
					window.parent.document.getElementById("contenidoR").style.height = tablaSize;
					resizeFrame();
				};
				document.body.appendChild(dimmer);
				editarCandidato.style.visibility = 'visible';
			return false; 
			}
		else
			ventanaError("Error: Porfavor seleccione un registro haciendo click sobre alguna de las celdas.", 1);		
		tablaSize = document.getElementById("todo").style.height;
		 document.getElementById("todo").style.height = (window.innerHeight+300) + 'px';
		 window.parent.document.getElementById("tabla").style.height = (window.innerHeight+300) + 'px';
		 window.parent.document.getElementById("contenidoR").style.height = (window.innerHeight+300) + 'px';
		
	});

	function checkTecnologias(tecs)
	{
		var i;
		var res= tecs.split(",");
		$("#tecnologiaEditar :input:not(:checked)").each(function() {
	        for(i=0; i<(res.length-1); i++)
	        	{
	        	if($(this).val()==res[i])
	        		{
	        		$(this).prop('checked', true);
	        		}
	        	}
	    });
	}
	
	function obtenerTecnologiasEditar()
	{
		var tecnologias = "";
		var chkArray = [];
		$("#tecnologiaEditar input:checked").each(function() {
	        chkArray.push($(this).val());
	    });
		tecnologias = chkArray.join(',') + ",";
		return tecnologias;
	}
	
	function obtenerTecnologiasCandidato(idCandidato)
	{
		$.ajax({
			url:'/Aplicacion1.3/AgregarTecnologia',
			type:'POST',
			async: false,
			data:'editar='+3+'&idCandidato=' + idCandidato ,
			success: function(resultado) {
				tecno = "" + resultado + "";
				}
		});//fin .ajax()
		return false;
	}

	/* Envío o servlet para editar registro*/
	$('#btnEditar').click( function() {
		$('.error').remove();
		$('#resultado_tecnologia').remove();
		if( obtenerTecnologiasEditar()==""|| obtenerTecnologiasEditar()==",")
		{ 
			$('<img src="../../images/iconos/stop32.png" id="resultado_tecnologia" class="validar"/>').appendTo('#tecnologia_img'); 
			$('#validacion').append('<p class="error">Error: Por favor, seleccione las tecnologías que el candidato conoce, o de de alta nuevas en la pestaña Tecnologías.</p>');
		}
		else
		if(
			validarNombre($('#nombre').val()) &&
			validarApellido($('#paterno').val()) &&
			validarEmail($('#email').val()) &&
			validarTelefono($('#telefono').val()) &&
			validarRFC($('#rfc').val()) &&
			validarTexto($('#tecnologia').val()) &&
			validarTexto($('#palabras').val())
			)
		{
			if( ( $('#materno').val()!='' && validarApellido($('#materno').val())) || $('#materno').val()=='' )
			{
				enviarEdicion();
				var editarCandidato = document.getElementById("editarCandidato");
				editarCandidato.style.visibility = 'hidden';
				document.body.removeChild(dimmer);
			}else
				$('#validacion').append('<p class="error">Error al registrar al candidato, por favor, verifique los datos.</p>');
		}else
			$('#validacion').append('<p class="error">Error: verifique los campos marcados.</p>');
		document.getElementById("todo").style.height = tablaSize;
		window.parent.document.getElementById("contenidoR").style.height = tablaSize;
		resizeFrame();
	});
			
	function enviarEdicion()
	{
		$.ajax({
			url:'/Aplicacion1.3/EditarCandidato',
			type:'POST',
			data:'idCandidato=' + idCandidato +
			'&nombre=' + $("#nombre").val() +
			'&apeMaterno='+ $("#materno").val() +
			'&apePaterno='+ $("#paterno").val() +
			'&curp='+ $("#curpEditar").val() +
			'&rfc='+ $("#rfc").val() +
			'&numero='+ $("#telefono").val() +
			'&email='+ $("#email").val() +
			'&palabras='+ $("#palabras").val() +
			'&tecnologia='+ obtenerTecnologiasEditar(),
			success: function(resultado) {
				ventanaError(resultado, 0);
				re = 1;
				},
			error: function( response, texStatus, errorThrown){
				if(errorThrown != '')
					ventanaError("Error: " + errorThrown, 1);
				else
					ventanaError("Error: " + response.responseText, 1);
			}
		});//fin .ajax()
		return false;
	}
	
	/*Cancelar registro*/
	$('#btnCancelar').click(function(){
		var editarCandidato = document.getElementById("editarCandidato");
		editarCandidato.style.visibility = 'hidden';
		document.body.removeChild(dimmer);
		document.getElementById("todo").style.height = tablaSize;
		window.parent.document.getElementById("contenidoR").style.height = tablaSize;
		resizeFrame();
		
	});
	
	/*Ventanna de error*/
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
			location.reload();
			error.style.visibility = 'hidden';
			document.body.removeChild(dimmerError);
			$("#info").html('');
			if(re==1)
				window.location.reload();
			re=0;
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
		if(re==1)
			window.location.reload();
		red = re = 0;
	});
	
	resizeFrame();
    
	$('.paginate_disabled_previous').click(function(){
    	resizeFrame();
    });
	
    $('.paginate_enabled_next').click(function(){
    	resizeFrame();
    });
    
    function resizeFrame()
    {
    	var iframe = window.parent.document.getElementById('tabla');
	    var container = document.getElementById('todo');
	    iframe.style.height = (container.offsetHeight) + 'px';
    }
    
    $('#nuevoRegistro').click(function(){
		window.location = "NuevoCandidato.jsp";	
    });
});	

/* Retorna el objeto seleccionado*//*
function fnGetSelected( oTableLocal )
{
	return oTableLocal.$('tr.row_selected');
}
*/

function fnGetSelected( oTableLocal )
{
	var aReturn = new Array();
	var aTrs = oTableLocal.fnGetNodes();
	
	for ( var i=0 ; i<aTrs.length ; i++ )
	{
		if ( $(aTrs[i]).hasClass('row_selected') )
		{
			aReturn.push( aTrs[i] );
		}
	}
	return aReturn;
}

