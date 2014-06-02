<%@page import="clases.Reclutador"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	HttpSession sesion = request.getSession();
	Reclutador re = null;
	if(sesion.isNew() || sesion.getAttribute("reclutador")==null)
	{
		System.out.println("La sesion es nueva");
		if(sesion!=null)
			sesion.invalidate();
		response.sendRedirect("../index.jsp");
		return;
	}else
	{
		re = (Reclutador) sesion.getAttribute("reclutador");
		sesion.setAttribute("idReclutador", re.idReclutador);		
	}
%>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Sesión de reclutador</title>
	<link rel="stylesheet" type="text/css" href="../css/style.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/formulario.css">
	<script type="text/javascript" language ="javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" language ="javascript" src="../js/validar_inicioSesion.js"></script>
	<script type="text/javascript" language="javascript">
	contenido.style.height = window.innerHeight + '100px';
	</script>
</head>

<body>
<div id="contenedor">

<div id="header">
	<div id="sesion">
		Bienvenido <%=re.getNombre()%> <%=re.getPaterno()%>
		<a href="cerrarSesion.jsp" id="cerrar_sesion">Cerrar Sesion</a>
	</div>
	<div id="menuCabecera">
		<ul id="listaMenuCabecera" class="barraNavegacion">
			<li><a href="Reclutador.jsp" title="consultar" >Candidatos</a></li>
			<li><a href="Tecnologias.jsp" title="tecnologias">Tecnologias</a></li>
			<li><a href="SesionCandidato.jsp" title="Registrar" class="paginaActual">Cuenta</a></li>
		</ul>
	</div>
</div>

<div id="contenido">
	<form action="/Aplicacion1.3/Login" name ="form" method="POST" id="cambiarPass">
		<fieldset >
			<legend>Datos de reclutador</legend>
			<span id= "validacion"></span>
			<p class="conSalto">Nombre: <%=re.getNombre() + " " +re.getPaterno() + " " + re.getMaterno()%></p>
			<p class="conSalto">Nombre de usuario:  <%=re.getUser() %> </p>
			<br>
			<p>
			<label>Contraseña actual</label>
			<input type="password" name="pass" id="passActual">
			</p>
			<p>
			<label>Nueva contraseña</label>
			<input type="password" name="pass" id="pass">
			</p>
			<p>
			<label>Confirmar contraseña</label>
			<input type="password" name="pass2" id="pass2">
			</p>
			<div id="botones">
			<a href="javascript:void(0)" id="editarRe" class="boton">Actualizar</a>
			<a href="javascript:void(0)" id="CandelarRe" class="boton">Cancelar</a>
			</div>
		</fieldset>
	</form>
</div>

<div id="ventana">
	<span id="info"></span>
</div>

<div id="PiePag">
	<span >México 2014 | 
	<a href="#" title="Sobre este sitio web">Nosotros</a> | 
	<a href="#" title="Contactanos">Contacto</a></span> |
	<span ><a href="#" title="Administración">Iniciar Sesión</a></span>
</div>

</div>
</body>
</html>