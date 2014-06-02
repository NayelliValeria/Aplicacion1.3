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
				response.sendRedirect("../index.jsp");
				return;
			}else
			{
				re = (Reclutador) sesion.getAttribute("reclutador");
				sesion.setAttribute("idReclutador", re.idReclutador);		
			}
		%>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Sesi�n de reclutador</title>
		<link rel="stylesheet" type="text/css" href="../css/MenuDesplegable.css">
		<link rel="stylesheet" type="text/css" href="../css/style.css">
		<script type="text/javascript" src="../js/menu.js"></script>
	</head>

	<body>		
		<div id="header">
			<div id="sesion">
				<p>Bienvenido <%=re.getNombre()%> <%=re.getPaterno()%></p>
				<p><a href="cerrarSesion.jsp" id="cerrar_sesion">Cerrar Sesion</a></p>
			</div>
			<div id="menuCabecera">
				<ul id="menuDesplegable" class="menuD">
					<li><a href="" title="consultar" >Candidatos</a>
						<ul>
							<li><a id="consultarCandidatos" href="javascript:void(0)" >Consultar Candidatos</a></li>
							<li><a href="" title="Registrar" >Registrar Candidato</a></li>
						</ul>
					</li>
					<li><a href="" title="consultar" >Reclutadores</a>
						<ul>
							<li><a href="adm/MostrarReclutadores.jsp" title="consultar" >Consultar Reclutadores</a></li>
							<li><a href="adm/RegistrarReclutador.jsp" title="Registrar" >Registrar Reclutador</a></li>
						</ul>
					</li>
					<li><a href="Tecnologias.jsp" title="tecnologias">Tecnolog�as</a>
						<ul>
							<li><a href="" title="consultar" >Consultar Tecnolog�as</a></li>
							<li><a href="" title="Registrar" >Registrar Tecnolog�a</a></li>
						</ul>
					</li>
					<li><a href="SesionCandidato.jsp" title="Registrar" class="paginaActual">Cuenta</a></li>
				</ul>
			</div>
		</div>
		<div id="contenido">
			<iframe id="ifPrincipal"></iframe>
		</div>
		
		<div id="PiePag">
			<span >M�xico 2014 | 
			<a href="#" title="Sobre este sitio web">Nosotros</a> | 
			<a href="#" title="Contactanos">Contacto</a></span> |
			<span ><a href="#" title="Administraci�n">Iniciar Sesi�n</a></span>
		</div>
		
	</body>
</html>