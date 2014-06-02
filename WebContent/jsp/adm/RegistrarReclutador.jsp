<%@page import="clases.Reclutador"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
		response.sendRedirect("../../index.jsp");
		return;
	}else
	{
		String admin = sesion.getAttribute("Admin").toString(); 
		if(admin.equalsIgnoreCase("false"))
		{
			sesion.invalidate();
			response.sendRedirect("../../index.jsp");
			response.sendRedirect("adm/Administrador.jsp");
		}
		re = (Reclutador) sesion.getAttribute("reclutador");
		sesion.setAttribute("idReclutador", re.idReclutador);		
	}
%>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="../../css/style.css">
	<link rel="stylesheet" type="text/css" href="../../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../../css/formulario.css">
	<link rel="stylesheet" type="text/css" href="../../css/jquery.dataTables.css">
	<script type="text/javascript" language ="javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" language ="javascript" src="../../js/validar.js"></script>
	<script type="text/javascript" language ="javascript" src="../../js/nuevoReclutador.js"></script>
	<script type="text/javascript" language="javascript">
	contenido.style.height = window.innerHeight + '300px';
	</script>
</head>

<body>
<div id="contenedor">

<div id="header">
	<div id="sesion">
		Bienvenido Administrador. <%=re.getNombre()%> <%=re.getPaterno()%>
		<a href="../cerrarSesion.jsp" id="cerrar_sesion">Cerrar Sesion</a>
	</div>
	<div id="menuCabecera">
		<ul id="listaMenuCabecera" class="barraNavegacion">
			<li><a href="Administrador.jsp" title="consultar">Candidatos</a></li>
			<li><a href="MostrarReclutadores.jsp" title="consultar">Consultar Reclutadores</a></li>
			<li><a href="RegistrarReclutador.jsp" title="Registrar"  class="paginaActual">Registrar Reclutador</a></li>
			<li><a href="../Tecnologias.jsp" title="Tecnologias" >Tecnologías</a></li>
			<li><a href="SesionAdministrador.jsp" title="Registrar" >Cuenta</a></li>
		</ul>
	</div>
</div>

<div id="contenido">
	<span id="validacion"></span>
	<form action="/Aplicacion1.3/AgregarReclutador" name ="form" method="POST" class="nuevoReclutador">
		<div id="izq" class="agregarReclutador">
			<label>Apellido Paterno:</label>
			<input type="text" name="paterno" id="paterno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="1">
			<div id="paterno_img" class="checkImg"></div>
						
			<label>Nombre:</label>
			<input type="text" name="nombre" id="nombre" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="3">
			<div id="nombre_img" class="checkImg"></div>
						
			<label>Contraseña:</label>
			<input type="password" name="pass" id="pass" tabindex="5">
			<div id="pass_img" class="checkImg"></div>
			
		</div>
		<div id="der" class="agregarReclutador">
		
			<label>Apellido Materno:</label>
			<input type="text" name="materno" id="materno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="2">
			<div id="materno_img" class="checkImg"></div>
			
			
			<label>Usuario:</label>
			<input type="text" name="user" id="user" tabindex="4">
			<div id="user_img" class="checkImg"></div>
			
			<br><br>
			<input type="checkbox" id="Admin" value="si">Agregar permisos de administrador
		</div>
		
		<div id="botones">
		<p><a href="javascript:void(0)" id="agregar" class="boton">Agregar</a></p>
		<p><a href="javascript:void(0)" id="cancelar" class="boton">Cancelar</a></p>
		</div>
	</form>
</div>

<div id="ventana">
	<span id="info"></span>
	<a href="javascript:void(0)" id="btnCerrarVentanaError" class="cerrarError">Cerrar</a>
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