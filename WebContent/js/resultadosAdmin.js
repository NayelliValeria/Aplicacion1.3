/**
 * Requiere el archivo validar.js
 * 
 */

var valor;
$(function(){
	var aPos;
	var dimmerError;
	var idCandidato=0;
	var aData;
	var oTable;
	var re = 0; /*Reload yes or no*/
	var red=0;
	var tablaSize;

	var valor;
	var detalles;
	var tecno="";
	
	/**Tabla de resultados para administrador**/
	$('#resultadosAdmin').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"bPaginate": true,
		"sPaginateType":"full_numbers",
		"oLanguage":{
			"sSearch":"Buscar:",
			"sEmptyTable":"No se encontraron candidatos registrados",
			"sLengthMenu": 'Mostrar <select >'+
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
              { "mDataProp": "Nombre",		"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "Paterno", 	"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "Materno", 	"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "curp", 		"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "rfc", 		"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "email", 		"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "telefono",	"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "tecnologia",	"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "palabras",	"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "fecha",		"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "reclutador",	"sType": "string", "bVisible": true, "bSearchable": true },
              { "mDataProp": "id_candidato","sType": "string", "bVisible": false,"bSearchable": false}
             ],
		"aaSorting":[[1,"asc"]],
		"bInfo": true,
		"bAutoWidth": true,
		"bLengthChange": true,
		"bFilter": true,
		"bSort": true
	});
	
	oTable = $('#resultadosAdmin').dataTable();
	
	/* Seleccionar un registro*/
	$("#resultadosAdmin tbody").delegate("tr", "click", function(){
		deseleccionarTecnologias
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
			/*window.alert("idCandidato= "+idCandidato);*/
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

/*        if ( $(this).hasClass('row_selected') ) {
			$(this).removeClass('row_selected');
			idCandidato=0;
			aPos=0;
			aData=null;
		}else 
		{
			oTable.$('tr.row_selected').removeClass('row_selected');
			$(this).addClass('row_selected');
		}*/
    });
	
	$('#resultadosAdmin_length select').click(function(){
		resizeFrame();
	});
	
	$('.paginate_disabled_previous').click(function(){
    	resizeFrame();
    });
	
    $('.paginate_enabled_next').click(function(){
    	resizeFrame();
    });
    
    resizeFrame();
    
	/***************************Fin declaracion tablas*******************************/
	
	
	/*******************************Editar candidato*********************************/
	$('#curp').focus();
	//Para validar el CURP
		
	$("#curp").focus(function(){
		$('#resultado_curp').remove();
		document.getElementById('curpExistente').style.visibility='hidden';
	});
	
	$('#curp').blur(function(){
		$('.error').remove();
		valor=$('#curp').val();
		if(valor!='' && validarCURP(valor) )//validar CURP
		{
			trimmedstr = valor.replace(/\s+$/, '');
			$.ajax({//Se verifica si este CURP ya esta registrado
				url:'/Aplicacion1.3/verificarCURP',
				type:'POST',
				data:'curp=' + valor,
				success: function(resultado) {
					if(resultado!='1')
						{
						$('<img src="../../images/iconos/stop32.png" id="resultado_curp" class="validar"/>').appendTo('#curp_img');
						document.getElementById('curpExistente').style.visibility='visible';
						detalles = resultado;
						}
					},
				error:function(jqXHR, textStatus, errorThrown){
					if(jqXHR.responseText !== '')
						$('#validacion').append('<p class="error">'+jqXHR.responseText+'.</p>');
					else
					    $('#validacion').append('<p class="error">'+errorThrown+'.</p>');
					}
				});//fin .ajax()
		}else
			$('<img src="../../images/iconos/stop32.png" id="resultado_curp" class="validar"/>').appendTo('#curp_img');
	});
		
	//Para validar el apellido paterno
	$("#nombre").focus(function(){
		$('#resultado_nombre').remove();
	});
	
	$('#nombre').blur(function(){
		$('.error').remove(); 
		valor=$('#nombre').val();
		if(valor=='' || !validarNombre(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_nombre" class="validar"/>').appendTo('#nombre_img');
			$('#validacion').append('<p class="error">El nombre no es valido.</p>');
		}
	});
		
	//Para validar el apellido paterno
	$("#paterno").focus(function(){
		$('#resultado_paterno').remove();
	});
	
	$('#paterno').blur(function(){
		$('.error').remove(); 
		valor=$('#paterno').val();
		if(valor=='' || !validarApellido(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_paterno" class="validar"/>').appendTo('#paterno_img');
			$('#validacion').append('<p class="error">El apellido no es valido.</p>');
		}
	});
		
	//Para validar el apellido Materno
	$("#materno").focus(function(){
		$('#resultado_materno').remove();
	});
	
	$('#materno').blur(function(){
		$('.error').remove(); 
		valor=$('#materno').val();
		if(valor!='' && !validarApellido(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_materno" class="validar"/>').appendTo('#materno_img');
			$('#validacion').append('<p class="error">El apellido materno no es valido.</p>');
		}
	});
		
	//Para validar el e-mail
	$("#email").focus(function(){
		$('#resultado_email').remove();
	});
	
	$('#email').blur(function(){
		$('.error').remove(); 
		valor=$('#email').val();
		if(valor=='' || !validarEmail(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_email" class="validar"/>').appendTo('#email_img');
			$('#validacion').append('<p class="error">El e-mail no es valido.</p>');
		}
	});
	
	//Para validar el telefono
	$("#telefono").focus(function(){
		$('#resultado_telefono').remove();
	});
		
	$('#telefono').blur(function(){
		$('.error').remove(); 
		valor=$('#telefono').val();
		if(valor=='' || !validarTelefono(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_telefono" class="validar"/>').appendTo('#telefono_img');
			$('#validacion').append('<p class="error">El número telefónico no es valido.</p>');
		}
	});
	
	//Para validar el rfc
	$("#rfc").focus(function(){
		$('#resultado_rfc').remove();
	});
	
	$('#rfc').blur(function(){
		$('.error').remove(); 
		valor=$('#rfc').val();
		if(valor=='' || !validarRFC(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_rfc" class="validar"/>').appendTo('#rfc_img');
			$('#validacion').append('<p class="error">El RFC no es valido.</p>');
		}
	});
		
	//Para validar el textarea de tecnologias
	$("#tecnologia").focus(function(){
		$('#resultado_tecnologia').remove();
	});
	
	$('#tecnologia').blur(function(){
		$('.error').remove(); 
		valor=$('#tecnologia').val();
		if(valor=='' || !validarTexto(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_tecnologia" class="validar"/>').appendTo('#tecnologia_img');
			$('#validacion').append('<p class="error">Verifique el campo tecnologías.</p>');
		}
	});
		
	//Para validar el textarea de palabras clave
	$("#palabras").focus(function(){
		$('#resultado_palabras').remove();
	});
	
	$('#palabras').blur(function(){
		$('.error').remove(); 
		valor=$('#palabras').val();
		if(valor=='' || !validarTexto(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_palabras" class="validar"/>').appendTo('#palabras_img');
			$('#validacion').append('<p class="error">Verifique el campo Palabras clave del candidato.</p>');
		}
	});
		
	/********************Fin validación candidato *************************/
	
	/*********************Agregar nuevo candidato**************************/
	/*Funcion para el botón enviar*/	
	$('#agregar').click(function(){
		$('.error').remove();
		if( 
			validarCURP($('#curp').val()) &&
			validarNombre($('#nombre').val()) &&
			validarApellido($('#paterno').val()) &&
			validarApellido($('#materno').val()) &&
			validarEmail($('#email').val()) &&
			validarTelefono(quitarSeparador("-",$('#telefono').val()) ) &&
			validarRFC($('#rfc').val()) &&
			validarTexto($('#tecnologia').val()) &&
			validarTexto($('#palabras').val())
		){
			$.ajax({
				url:'/Aplicacion1.3/AgregarCandidato',
				type: 'POST',
				data: 
					'nombre=' + $("#nombre").val() +
					'&materno='+ $("#materno").val() +
					'&paterno='+ $("#paterno").val() +
					'&curp='+ $("#curp").val() +
					'&rfc='+ $("#rfc").val() +
					'&numero='+ quitarSeparador("-",$('#telefono').val() ) +
					'&email='+ $("#email").val() +
					'&palabras='+ $("#palabras").val() +
					'&tecnologia='+ $("#tecnologia").val(),
				success: function(resultado) {
						ventanaError("El candidato se ha registrado exitosamente", 0);
						window.location.href='Reclutador.jsp';
						},
				error:function(jqXHR, textStatus, errorThrown){
						if(jqXHR.responseText !== '')
							ventanaError("Error: " + jqXHR.responseText, 1);
						else
							ventanaError("Error: " + errorThrown, 1);
						}
			});
			idCandidato = 0;
		}else
			ventanaError("Lo sentimos, uno o más campos son incorrectos, por favor verifiquelos.", 1);
	});
		
	/*Funcion para el botón cancelar*/	
	$('#cancelar').click(function(){
		idCAndidato=0;
		location.reload();
	});
	
	//Mostrar detalles
	$('#detalles').click( function() {
		ventanaError(detalles,0);
	} );
		
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
			if(re==1)
				location.reload();
			 document.body.removeChild(this);   
			 error.style.visibility = 'hidden';
			 $("#info").removeAttr("p");
			 $("#info").html('');
		 };
		document.body.appendChild(dimmerError);
		error.style.visibility = 'visible';
		return false;
	}
	
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
		/*document.body.removeChild(dimmerError);   
		seguroEliminar.style.visibility = 'hidden';*/
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
					/*document.getElementById("todo").style.height = tablaSize;
					window.parent.document.getElementById("contenidoR").style.height = tablaSize;
					resizeFrame();*/
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
	
	function deseleccionarTecnologias()
	{
		$("#tecnologiaEditar input:checked").each(function() {
			$(this).prop('checked', false);
	    });
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
			validarTexto($('#palabras').val())
			)
		{
			if( ( $('#materno').val()!='' && validarApellido($('#materno').val())) || $('#materno').val()=='' )
			{
				enviarEdicion();
				var editarCandidato = document.getElementById("editarCandidato");
				editarCandidato.style.visibility = 'hidden';
				document.body.removeChild(dimmer);
				//location.reload();
			}else
				$('#validacion').append('<p class="error">Error al registrar al candidato, por favor, verifique los datos.</p>');
		}else
			$('#validacion').append('<p class="error">Error: verifique los campos marcados.</p>');
			
		document.getElementById("todo").style.height = tablaSize;
		window.parent.document.getElementById("contenidoR").style.height = tablaSize;
		resizeFrame();
		document.body.removeChild(dimmer);
	});
	
	$('#nuevoRegistro').click(function(){
			window.location = "../NuevoCandidato.jsp";	
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
		document.getElementById("todo").style.height = tablaSize;
		window.parent.document.getElementById("contenidoR").style.height = tablaSize;
		 resizeFrame();
		document.body.removeChild(dimmer);
	});
	
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
		resizeFrame();
	});
	
	function resizeFrame()
    {
    	var iframe = window.parent.document.getElementById('tabla');
	    var container = document.getElementById('todo');
	    iframe.style.height = (container.offsetHeight) + 'px';
    }
		
});//Fin function

/* Retorna el objeto seleccionado*/
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
		  
	
	
	