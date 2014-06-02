/**
 * Validación de usuario y contraseñas
 * Inicio de sesión
 */

$(function(){
	var valor;
		
	/*Funcion para el botón enviar*/	
	$('#enviar').click(function(){
		$('.error').remove();
		if($('#user').val()!='' && $('#pass').val()!='')
		{
			$('.error').remove();
			var user = $('#user').val();
			var pass = $('#pass').val();
			if(validarUsuario(user) && validarPassword(pass)){
				$.ajax({
				url:'Login',
				type:'POST',
				data:'user=' + user + '&pass=' + pass,
				success: function(resultado) {
					window.location.href = "jsp/Reclutador.jsp";
					},
				error:function(jqXHR, textStatus, errorThrown){
					if(jqXHR.responseText !== '')
						$('#validacion').append('<p class="error">'+jqXHR.responseText+'</p>');
					else
						$('#validacion').append('<p class="error">'+errorThrown+'</p>');
					}
				});//fin .ajax()
			}//fin if validaciones
			return false;
		}else {
			$('#validacion').append('<p class="error">Debe completar los datos requeridos.</p>');
			return false;
		}
	});
	
	/*Función para cambiar la contraseña*/
	$('#editarRe').click(function(){
		$('#validacion').html('');
		$('.error').remove();
		if(  $('#passActual').val()=='')
		{
			$('#validacion').append('<p class="error">Por favor ingrese su contraseña.</p>');
		}else
		if(
			$('#pass').val()!='' && validarPassword($('#pass').val()) 
			&& $('#pass2').val()!='' && validarPassword($('#pass2').val())
			&& $('#pass').val()==$('#pass2').val())
		{
			$.ajax({
				url:'/Aplicacion1.3/Login',
				type:'POST',
				data:
					'pass=' + $('#pass').val() + 
					'&pass2=' + $('#pass2').val() + 
					'&passActual=' +$('#passActual').val(),
				success: function(resultado) {
					$('#validacion').append('<p class="info">'+ resultado +'</p>');
					$('#passActual').val("");
					$('#pass').val(""); 
					$('#pass2').val("");
					},
				error:function(jqXHR, textStatus, errorThrown){
					if(jqXHR.responseText !== '')
						$('#validacion').append('<p class="error">'+jqXHR.responseText+'</p>');
					else
					    $('#validacion').append('<p class="error">'+errorThrown+'</p>');
					}
				});//fin .ajax()
			return false;
		}else{
			$('#validacion').append('<p class="error">Las contraseñas no coinciden.</p>');
			return false;
		}
	});

	$('#CandelarRe').click(function(){
		$('#validacion').html('');
		$('#passActual').val("");
		$('#pass').val(""); 
		$('#pass2').val("");
	});

	/*Editar nombre de Administrador*/
	$('#editarNombreAdmin').click(function(){
		$('.error').remove();
		$('#validacion').html('');
		if(	validarNombre($('#nombre').val()) &&
			validarApellido($('#paterno').val())
			)
		{
			if( ($('#materno').val()!='' && validarApellido($('#materno').val())) || $('#materno').val()=='' )
			$.ajax({
				url:'/Aplicacion1.3/editarAdmin',
				type:'POST',
				data:
					'&accion=nombres'  + 
					'&nombre=' +$('#nombre').val()+
					'&paterno=' +$('#paterno').val()+
					'&materno=' +$('#materno').val(),
				success: function(resultado) {
					$('#validacion').append('<p class="info">'+ resultado +'</p>');
					},
				error:function(jqXHR, textStatus, errorThrown){
					if(jqXHR.responseText !== '')
						$('#validacion').append('<p class="error">'+jqXHR.responseText+'</p>');
					else
					    $('#validacion').append('<p class="error">'+errorThrown+'</p>');
					}
				});//fin .ajax()
			return false;
		}else{
			$('#validacion').append('<p class="error">Error:Verifique la información.</p>');
			return false;
		}
	});
	
	$('#cancelareditarNombreAdmin').click(function(){
		location.reload();
	});
	
	/*Función para cambiar la contraseña adm*/
	$('#editarAdmin').click(function(){
		$('.error').remove();
		$('#validacion2').html('');
		if(  $('#passActual').val()=='')
		{
			$('#validacion2').append('<p class="error">Por favor ingrese su contraseña.</p>');
		}
		else
		if(
			$('#pass').val()!='' && validarPassword($('#pass').val()) 
			&& $('#pass2').val()!='' && validarPassword($('#pass2').val())
			&& $('#pass').val()==$('#pass2').val()
			)
		{
			$.ajax({
				url:'/Aplicacion1.3/editarAdmin',
				type:'POST',
				data:
					'accion=password' +
					'&pass=' + $('#pass').val() + 
					'&pass2=' + $('#pass2').val() + 
					'&passActual=' +$('#passActual').val(),
				success: function(resultado) {
					$('#validacion2').append('<p class="info">'+ resultado +'</p>');
					$('#passActual').val("");
					$('#pass').val(""); 
					$('#pass2').val("");
					},
				error:function(jqXHR, textStatus, errorThrown){
					if(jqXHR.responseText !== '')
						$('#validacion2').append('<p class="error">'+jqXHR.responseText+'</p>');
					else
					    $('#validacion2').append('<p class="error">'+errorThrown+'</p>');
					}
				});//fin .ajax()
			return false;
		}else{
			$('#validacion2').append('<p class="error">Las contraseñas no coinciden.</p>');
			return false;
		}
	});
	
	$('#editarAdminCancelar').click(function(){
		$('#pass').val(""); 
		$('#pass2').val("");
		$('#passActual').val("");
		$('#validacion2').html('');
	});
	
	//Para validar el nombre
	$("#nombre").focus(function(){
		$('#resultado_nombre').remove();
	});
	
	$('#nombre').blur(function(){
		$('.error').remove(); 
		valor=$('#nombre').val();
		if(valor=='' || !validarNombre($('#nombre').val()))
		{
			$('<img src="../../images/iconos/stop32.png" id="resultado_nombre" class="validar"/>').appendTo('#nombre_img');
			$('#validacion').append('<p class="error">Este no es un nombre valido.</p>');
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
			$('#validacion').append('<p class="error">Este no es un apellido valido.</p>');
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
			$('<img src="../../images/iconos/stop32.png" id="resultado_materno" class="validar"/>').appendTo('#paterno_img');
			$('#validacion').append('<p class="error">Este no es un apellido valido.</p>');
		}
	});

});//Fin function

/*Funciones para validar los datos*/

function validarUsuario(correo) {
	var expresion = /^\w/;
	return expresion.test(correo);
}

function validarPassword(cadena){
	var expresion = /^\w/;
	return expresion.test(cadena);
}