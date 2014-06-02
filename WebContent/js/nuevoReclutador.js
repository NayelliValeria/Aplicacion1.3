/**
 * Requiere el archivo validar.js
 * 
 */

var valor;

$(function(){
	var valor;
	var detalles;
	var red = 0;
	
	//Para validar el nombre
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
			$('#validacion').append('<p class="error">El apellido paterno no es valido.</p>');
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
	
	//Para validar el usuario
	$("#user").focus(function(){
		$('#resultado_user').remove();
	});
		
	$('#user').blur(function(){
		$('.error').remove(); 
		valor=$('#user').val();
		if(valor=='' || !validarUsuario(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_user" class="validar"/>').appendTo('#user_img');
			$('#validacion').append('<p class="error">El nombre de Usuario no es valido.</p>');
		}
	});
	
	//Para validar el telefono
	$("#pass").focus(function(){
		$('#resultado_pass').remove();
	});
		
	$('#pass').blur(function(){
		$('.error').remove(); 
		valor=$('#pass').val();
		if(valor=='' || !validarPassword(valor))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_pass" class="validar"/>').appendTo('#pass_img');
			$('#validacion').append('<p class="error">El password no es valido.</p>');
		}
	});
		
	/*Funcion para el botón enviar*/	
	$('#agregar').click(function(){
		$('.error').remove();
		if( 
				validarNombre($('#nombre').val()) &&
				validarApellido($('#paterno').val()) &&
				validarUsuario($('#user').val()) &&
				validarPassword($('#pass').val()) 
		)
		{
			if($('#materno').val()=='')
				enviarNuevoReclutador();
			else
			if($('#materno').val()!='' && validarApellido($('#materno').val()))
				enviarNuevoReclutador();
			else
				ventanaError("Error al registrar reclutador, verifique la información.",1);
		}else
			ventanaError("Lo sentimos, uno o más campos son incorrectos, por favor verifique la información.", 1);
	});
		
	/*Funcion para el botón cancelar*/	
	$('#cancelar').click(function(){
		location.reload();
	});
	
	/*Ventana pop-up de error*/
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
			 document.body.removeChild(this);   
			 error.style.visibility = 'hidden';
			 $("#info").removeAtrr('p');
		 };
		 document.body.appendChild(dimmerError);
		 error.style.visibility = 'visible';
		return false;
	}
	
	/*boton cerrar de la ventana de error*/
	$('#btnCerrarVentanaError').click(function(){
		var error = document.getElementById("ventana");
		error.style.visibility = 'hidden';
		document.body.removeChild(dimmerError);
		$("#info").html('');
		if(red==1)
			window.location.href='MostrarReclutadores.jsp';
	});
	
	/*envìo de datos de registro de reclutador*/
	function enviarNuevoReclutador()
	{
		var admin = 0;
		if( document.getElementById("Admin").checked)
			admin =1;
		$.ajax({
			url:'/Aplicacion1.3/AgregarReclutador',
			type: 'POST',
			data: 
				'nombre=' + $("#nombre").val() +
				'&materno='+ $("#materno").val() +
				'&paterno='+ $("#paterno").val() +
				'&user='+ $("#user").val() +
				'&pass='+ $("#pass").val() + 
				'&admin=' + admin,
			success: function(resultado) {
				ventanaErrorReclutadores(" " + resultado, 0);
				red = 1;
				setTimeOut(function(){window.location.href='MostrarReclutadores.jsp';},2000);
				},
			error:function(jqXHR, textStatus, errorThrown){
				if(jqXHR.responseText !== '')
					ventanaError("Error: " + jqXHR.responseText, 1);
				else
					ventanaError("Error: " + errorThrown, 1);
				}
		});
	}
	
	/*Ventana de error*/
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
			 window.location.href='MostrarReclutadores.jsp';
		 };
		 document.body.appendChild(dimmerError);
		 error.style.visibility = 'visible';
		 return false;
	}
		
});//Fin function
		  
	
	
	