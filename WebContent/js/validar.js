/**
 * Funciones para validar datos
 */

	/*Valida un nombre*/
	function validarNombre(cadena)
	{
		var expresion = /^([A-Za-z]*[áéíóúÁÉÍÓÚñÑ]*)+(\s{1}([A-Za-z][áéíóúÁÉÍÓÚñÑ]*)*)*\S$/;
		return expresion.test(cadena);
	}
	
	/*Valida un apellido*/
	function validarApellido(cadena)
	{
		//var expresion = /^[A-Za-z]([^\s])/;
		var expresion = /^([A-Za-z]+[áéíóúÁÉÍÓÚñÑ]*||[A-Za-z]*[áéíóúÁÉÍÓÚñÑ]+)+(\s{1}([A-Za-z]+[áéíóúÁÉÍÓÚñÑ]*||[A-Za-z]*[áéíóúÁÉÍÓÚñÑ]+)+)*\S$/;
		return expresion.test(cadena);
	}
	
	/*Validao un CURP*/
	function validarCURP(cadena)
	{
		var expresion = /[A-Z]{4}[0-9]{6}[H,M][A-Z]{5}[0-9]{2}$/;
		return expresion.test(cadena);
	}
	
	/*Valida un e-mail*/
	function validarEmail( cadena )
	{
		var expresion = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
		return expresion.test(cadena);
	}
	
	/*Valida un telèfono*/
	function validarTelefono( cadena )
	{
		cadena = quitarSeparador("-",cadena);
		var expresion = /[0-9]{8}[0-9]*$/;
		return expresion.test(cadena);
	}
	
	/*Valida numeros*/
	function validarNumeros( cadena )
	{
		var expresion = /[0-9]+$/;
		return expresion.test(cadena);
	}
	
	/*Valida un RFC*/
	function validarRFC( cadena )
	{
		var expresion = /[A-Z]{4}[0-9]{6}[A-Z0-9]{3}$/;
		return expresion.test(cadena);
	}
	
	/*Valida un texto*/
	function validarTexto( cadena )
	{
		var expresion = /^\w/;
		return expresion.test(cadena);
	}
	
	/*Valida un usuario*/
	function validarUsuario( cadena )
	{
		var expresion = /^\w/;
		return expresion.test(cadena);
	}
	
	/*Valida una contraseña*/
	function validarPassword( cadena )
	{
		var expresion = /^\w{4}\w*/;
		return expresion.test(cadena);
	}
	
	/* Quita los separadores de una cadena
	 * Separador, caracter a suprimir
	 * cadena, cadena a limpiar
	 * */
	function quitarSeparador(separador,cadena)
	{
		while(cadena.indexOf(separador, 0) != -1)
			cadena = cadena.replace(separador,"");
		return cadena;
	}
	
	/*Mascaras*/
	function mascaraTelefono(tel)
	{
		var valor = tel.value;
		var val = valor;
		valor = quitarSeparador("-", valor);
		var regresar  = "";
		if(validarNumeros(valor))
		{
			var i;
			for( i=0; i<valor.length; i++)
			{
				regresar += valor[i];
				if( (i+1)%2 == 0 && (i+1)!=valor.length)
				{
					regresar += "-";
				}
			}
			tel.value = regresar;
		}else
			tel.value = val;
	}
	
	/* Convierte a ayúsculas*/
	function aMayusculas(elemento)
	{
		var val  = elemento.value;
		elemento.value = val.toUpperCase().trim();
	}
	
	/* Convierte  a minúsculas */
	function aMinusculas(elemento)
	{
		var val  = elemento.value;
		elemento.value = val.toLowerCase().trim();
	}