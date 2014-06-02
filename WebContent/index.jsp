<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>recluIT - Iniciar Sesión</title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/formulario.css">
	<link rel="stylesheet" type="text/css" href="css/login.css">
	<script type="text/javascript" language="javascript" src="js/jquery.js"/></script>
	<script type="text/javascript" language="javascript" src="js/validar_inicioSesion.js"/></script>
</head>
<%
HttpSession sesion = request.getSession();
if( sesion.getAttribute("reclutador")!=null)
{
	System.out.println("Redireccionando");
	String admin = sesion.getAttribute("Admin").toString(); 
	if(admin.equalsIgnoreCase("false"))
	{
		response.sendRedirect("jsp/Reclutadir.jsp");
	}else
		response.sendRedirect("jsp/adm/Administrador.jsp");
}
%>
<body>
<div id="contenedor">

<div id="contenido_login">
	<form action="" method="POST" >
		<fieldset>
			<legend>Iniciar Sesión</legend>
			<span id="validacion"></span>
			<label>Usuario:</label> 
			<input type="text" name="user" id="user" placeholder="Nombre de usuario">
			<div id="user_img" class="checkImg"></div>
			<br>
			<label>Contraseña:</label> 
			<input type="password" name="pass" id="pass" placeholder="Contraseña">
			<div id="pass_img" class="checkImg"></div>
			<br>
			<button type="submit" id="enviar">Entrar</button>
		</fieldset>
	</form>
</div>

<div id="footer">
	<span >México 2014 | 
	<a href="#" title="Sobre este sitio web">Nosotros</a> | 
	<a href="#" title="Contactanos">Contacto</a></span> |
	<span ><a href="#" title="Administración">Iniciar Sesión</a></span>
</div>

</div>
</body>
</html>