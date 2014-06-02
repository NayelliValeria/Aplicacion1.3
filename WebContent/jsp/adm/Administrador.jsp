<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="clases.Reclutador" %>
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
		sesion.invalidate();
		response.sendRedirect("../../index.jsp");
		return;
	}else
	{
		String admin = sesion.getAttribute("Admin").toString(); 
		if(admin.equalsIgnoreCase("false"))
		{
			response.sendRedirect("../Reclutador.jsp");
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
	<script type="text/javascript" language="javascript" src="../../js/jquery"></script>
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
			<li><a href="Administrador.jsp" title="consultar" class="paginaActual">Candidatos</a></li>
			<li><a href="MostrarReclutadores.jsp" title="consultar" >Consultar Reclutadores</a></li>
			<li><a href="RegistrarReclutador.jsp" title="Registrar" >Registrar Reclutador</a></li>
			<li><a href="../Tecnologias.jsp" title="Tecnologias" >Tecnolog�as</a></li>
			<li><a href="SesionAdministrador.jsp" title="Registrar" >Cuenta</a></li>
		</ul>
	</div>
</div>

<div id="contenidoR">
	<iframe src="ResultadosAdmin.jsp" id="tabla"></iframe>
</div>

<div id="footer">
	<span >M�xico 2014 | 
	<a href="#" title="Sobre este sitio web">Nosotros</a> | 
	<a href="#" title="Contactanos">Contacto</a></span> |
	<span ><a href="#" title="Administraci�n">Iniciar Sesi�n</a></span>
</div>


</div>

</body>
</html>