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
	<title>Sesión de Administrador</title>
	<link rel="stylesheet" type="text/css" href="../../css/style.css">
	<link rel="stylesheet" type="text/css" href="../../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../../css/formulario.css">
	<script type="text/javascript" language ="javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" language ="javascript" src="../../js/validar_inicioSesion.js"></script>
	<script type="text/javascript" language ="javascript" src="../../js/validar.js"></script>
	<script type="text/javascript" language="javascript">
	contenido.style.height = window.innerHeight + '100px';
	</script>
</head>

<body>
<div id="contenedor">
<div id="header">
	<div id="sesion">
		Bienvenido Administrador. <%=re.getNombre()%> <%=re.getPaterno()%> <%=re.getMaterno()%>
		<a href="../cerrarSesion.jsp" id="cerrar_sesion">Cerrar Sesion</a>
	</div>
	<div id="menuCabecera">
		<ul id="listaMenuCabecera" class="barraNavegacion">
			<li><a href="Administrador.jsp" title="consultar">Candidatos</a></li>
			<li><a href="MostrarReclutadores.jsp" title="consultar" >Consultar Reclutadores</a></li>
			<li><a href="RegistrarReclutador.jsp" title="Registrar" >Registrar Reclutador</a></li>
			<li><a href="../Tecnologias.jsp" title="Tecnologias" >Tecnologías</a></li>
			<li><a href="SesionAdministrador.jsp" title="Registrar" class="paginaActual">Cuenta</a></li>
		</ul>
	</div>
</div>
<div id="contenido">
	<form action="/Aplicacion1.3/editarAdmin" name ="form" method="POST" id="cambiarPass">
		<fieldset >
			<legend>Datos de Administrador</legend>
			<span id= "validacion"></span>
			<label class="cambiarNom">Nombre de usuario: <%=re.getUser() %></label> 
			<br>
			<p>
			<label class="cambiarNom">Apellido Paterno:</label>
			<input type="text" value=<%=re.getPaterno()%> name="paterno" id="paterno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="1">
			<div id="paterno_img" class="checkImg"></div>
			</p>
			
			<p>
			<label class="cambiarNom">Apellido Materno:</label>
			<%String mater = re.getMaterno();
			if(mater.equals(""))
			{
				%>
				<input type="text" name="materno" value="" id="materno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="2">
			<%}else {
			%>
			<input type="text" name="materno" value=<%=mater%> id="materno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="2">
			<%} %>	
			<div id="materno_img" class="checkImg"></div>
			</p>
			
			<p>
			<label class="cambiarNom">Nombre:</label>
			<input type="text" name="nombre" value=<%=re.getNombre()%> id="nombre" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="3">
			<div id="nombre_img" class="checkImg"></div>
			</p>
			
			<div id="botones">
			<a href="javascript:void(0)" id="editarNombreAdmin" class="boton">Guardar cambios</a>
			<a href="javascript:void(0)" id="cancelareditarNombreAdmin" class="boton">Cancelar</a>
			</div>
		</fieldset>
		<fieldset >
			<legend>Cambiar contraseña</legend>
			<span id= "validacion2"></span>
			<p>
			<label class="pass">Contraseña actual</label>
			<input type="password" name="pass" id="passActual">
			</p>
			<p>
			<label class="pass">Nueva contraseña</label>
			<input type="password" name="pass" id="pass">
			</p>
			<p>
			<label class="pass">Confirmar contraseña</label>
			<input type="password" name="pass2" id="pass2">
			</p>
			<div id="botones">
			<a href="javascript:void(0)" id="editarAdmin" class="boton">Cambiar contraseña</a>
			<a href="javascript:void(0)" id="editarAdminCancelar" class="boton">Cancelar</a>
			</div>
		</fieldset>
	</form>
</div>

<div id="ventana">
	<span id="info"></span>
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