<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="clases.Reclutador" %>
<%@ page import="clases.Query" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Reclutadores Admin</title>
	<link rel="stylesheet" type="text/css" href="../../css/style.css">
	<link rel="stylesheet" type="text/css" href="../../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../../css/formulario.css">
	<link rel="stylesheet" type="text/css" href="../../css/jquery.dataTables.css">
	<script type="text/javascript" language="javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="../../js/jquery.dataTables.js"></script>
	<script type="text/javascript" language="javascript" src="../../js/resultadosReclutadores.js"></script>
	<script type="text/javascript" language ="javascript" src="../../js/validar.js"></script>
	<script type="text/javascript" language ="javascript" src="../../js/nuevoReclutador.js"></script>
</head>
<%
	HttpSession sesion = request.getSession();
	Reclutador re = null;
	if(sesion.isNew() || sesion.getAttribute("reclutador")==null)
	{
		System.out.println("La sesion es nueva");
		sesion.invalidate();
		response.sendRedirect("../../index.jsp");
		return;
	}
	String admin = sesion.getAttribute("Admin").toString(); 
	if(admin.equalsIgnoreCase("false"))
	{
		sesion.invalidate();
		response.sendRedirect("../../index.jsp");
		response.sendRedirect("adm/Administrador.jsp");
	}
	re = (Reclutador) sesion.getAttribute("reclutador");
	sesion.setAttribute("idReclutador", re.idReclutador);
	sesion.setAttribute("nombreReclutador", re.getNombre() +" " + re.getPaterno() + " " +re.getMaterno());
	Query q =  new Query();
	ArrayList<Reclutador> reclutadores  = q.consultarReclutadoresAdmin();
%>

<body>
<div id="contenedor">

<div id="header">
	<div id="sesion">
		Bienvenido Administrador. <%=re.getNombre()%> <%=re.getPaterno()%>
		<a href="../cerrarSesion.jsp" id="cerrar_sesion">Cerrar Sesion</a>
	</div>
	<div id="menuCabecera">
		<ul id="listaMenuCabecera" class="barraNavegacion">
			<li><a href="Administrador.jsp" title="consultar" >Candidatos</a></li>
			<li><a href="MostrarReclutadores.jsp" title="consultar" class="paginaActual">Consultar Reclutadores</a></li>
			<li><a href="RegistrarReclutador.jsp" title="Registrar" >Registrar Reclutador</a></li>
			<li><a href="../Tecnologias.jsp" title="Tecnologias" >Tecnologías</a></li>
			<li><a href="SesionAdministrador.jsp" title="Registrar" >Cuenta</a></li>
		</ul>
	</div>
</div>
	
<div id="contenido">
	<div id= "buscadorReclutadores">
		<p><a href="javascript:void(0)" id="editar" class="boton">Editar registro</a></p>
		<p><a href="javascript:void(0)" id="eliminar" class="boton">Eliminar registro</a></p>
	</div>
	<div id="tableReclutadores">
	<table class="display" id="resultados" >
		<thead>
			<tr>
			<th>Nombre</th>
			<th>Apellido Paterno</th>
			<th>Apellido Materno</th>
			<th id="Usuario">Usuario</th>
			<th>Permisos</th>
			<th id ="Pas">Pas</th>
			<th id="id_candidato">id_candidato</th>
			</tr>
		</thead>
		<tbody>
		<%
		String ad="";
			for(int i=0; i<reclutadores.size(); i++)
			{
				Reclutador ca =  reclutadores.get(i);
				if(ca.getAdmin())
					ad = "Administrador";
				else ad="Reclutador";
			%>
			<tr>
				<td><%=ca.getNombre() %></td>
				<td><%=ca.getPaterno() %></td>
				<td><%=ca.getMaterno() %></td>
				<td><%=ca.getUser() %></td>
				<td><%=ad %></td>
				<td><%=ca.getPass() %></td>
				<td><%=ca.idReclutador %></td>
			</tr>
			<%
			}
		%>
	</tbody>
	<tfoot>
		<tr>
			<th>Nombre</th>
			<th>Apellido Paterno</th>
			<th>Apellido Materno</th>
			<th>Usuario</th>
			<th>Permisos</th>
			<th>Pas</th>
			<th>id_candidato</th>
		</tr>
	</tfoot>
	</table>
	</div>	
</div>

<div id="editarReclutador">
	<span id="validacion"></span>
	<form action="/Aplicacion1.3/editarReclutador" name ="form" method="POST" class="nuevoCandidato">
		<div id="izq">
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
		<div id="der">
			<label>Apellido Materno:</label>
			<input type="text" name="materno" id="materno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="2">
			<div id="materno_img" class="checkImg"></div>
						
			<label>Usuario:</label>
			<input type="text" name="user" id="user" tabindex="4">
			<div id="user_img" class="checkImg"></div>
			
			<br><br>
			<input type="checkbox" id="Admin" value="si">Agregar permisos de administrador
		</div>
	</form>
	<div id="botonesEd">
		<p><a href="javascript:void(0)" id="btnEditar" class="boton">Guardar</a></p>
		<p><a href="javascript:void(0)" id="btnCancelar" class="boton">Cancelar</a></p>
	</div>
</div>
	
<div id="seguroEliminar" title="ADVERTENCOA">
	<p>¿Seguro que desea eliminar este registro?</p>
	<a href="" id="siQuieroEliminar">Eliminar</a>
	<a href="" id="noQuieroEliminar">No</a>
</div>

<div id="ventana">
	<span id="info"></span>
	<p><a href="javascript:void(0)" id="btnCerrarVentanaError" class="cerrarError">Cerrar</a></p>
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