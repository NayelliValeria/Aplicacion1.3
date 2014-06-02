<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="clases.Reclutador"%>
<%@page import="clases.Tecnologia"%>
<%@page import="clases.Query" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	HttpSession sesion = request.getSession();
	Reclutador re = null;
	boolean admin=false;
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
		admin = re.getAdmin();
		sesion.setAttribute("idReclutador", re.idReclutador);		
	}
	Query q =  new Query();
	ArrayList<Tecnologia> tec  = q.buscarTecnologias();
%>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="../css/style.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.css">
	<link rel="stylesheet" type="text/css" href="../css/formulario.css">
	
	<script type="text/javascript" language ="javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" language ="javascript" src="../js/jquery.dataTables.js"></script>
	<script type="text/javascript" language ="javascript" src="../js/validar.js"></script>
	<script type="text/javascript" language ="javascript" src="../js/tecnologias.js"></script>
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
	<%
		if(admin)
		{
	%>
		<li><a href="adm/Administrador.jsp" title="consultar">Candidatos</a></li>
		<li><a href="adm/MostrarReclutadores.jsp" title="consultar" >Consultar Reclutadores</a></li>
		<li><a href="adm/RegistrarReclutador.jsp" title="Registrar" >Registrar Reclutador</a></li>
		<li><a href="Tecnologias.jsp" title="Tecnologias" class="paginaActual">Tecnologías</a></li>
		<li><a href="adm/SesionAdministrador.jsp" title="Registrar" >Cuenta</a></li>
	<%}else{ %>
		<li><a href="Reclutador.jsp" title="consultar" >Candidatos</a></li>
		<li><a href="Tecnologias.jsp" title="Tecnologias" class="paginaActual">Tecnologías</a></li>
		<li><a href="SesionCandidato.jsp" title="Registrar" >Cuenta</a></li>
	<%} %>
	</ul>
	</div>
</div>

<div id="contenido">
<div id= "buscadorTecnologias">
		<p><a href="javascript:void(0)" id="agregar" class="botonMenu2">Agregar tecnología<img alt="" src="../images/iconos/plus32.png"></a></p>
		<p><a href="javascript:void(0)" id="editar" class="botonMenu2">Editar tecnología<img alt="" src="../images/iconos/pencil32.png"></a></p>
		<p><a href="javascript:void(0)" id="eliminar" class="botonMenu2Ultimo">Eliminar tecnología<img alt="" src="../images/iconos/minus32.png"></a></p>
</div>
<div id="todoTecnologias">
	<table class="display" id="resultados">
		<thead>
			<tr>
			<th>Nombre</th>
			<th>Descripción</th>
			<th id="id">id</th>
			</tr>
		</thead>
		<tbody>
		<%
		if(tec!=null)
			for(int i=0; i<tec.size(); i++)
			{
				Tecnologia te =  tec.get(i);
			%>
			<tr>
				<td><%=te.getNombre() %></td>
				<td><%=te.getDescripcion() %></td>
				<td id="id"><%=te.getId() %></td>
			</tr>
			<%
			}
		%>
	</tbody>
	<tfoot>
		<tr>
			<th>Nombre</th>
			<th>Descripción</th>
			<th></th>
			</tr>
	</tfoot>
	</table>
</div>
</div>

<div id="editarTecnologia">
	<span id="validacion"></span>
	<form action="" name ="form" method="POST" class="nuevoCandidato">
		<label>Nombre de la tecnología:</label>
		<input type="text" name="nomEdit" id="nomEdit" onkeyup="javascript:aMayusculas(this)" tabindex="1" placeholder="Nombre de la tecnología" maxlength="50">
		<div id="nom_img" class="checkImg"></div>
			
		<label>Descripción:</label>
		<textarea rows="3" cols="20" name="descEdit" id="descEdit" tabindex="9" placeholder="Descripción de la tecnología"></textarea>
		<div id="desc_img" class="checkImg"></div>
	
		<div id="botones">
		<p><a href="javascript:void(0)" id="guardarCambios" class="boton">Guardar</a></p>
		<p><a href="javascript:void(0)" id="cancelarCambios" class="boton">Cancelar</a></p>
		</div>
	</form>
</div>


<div id="nuevaTecnologia">
	<span id="validacion"></span>
	<form action="/Aplicacion1.3/AgregarCandidato" name ="form" method="POST" class="nuevoCandidato">
		<label>Nombre de la tecnología:</label>
		<input type="text" name="nom" id="nom" onkeyup="javascript:aMayusculas(this)" tabindex="1" placeholder="Nombre de la tecnología" maxlength="50">
		<div id="nom_img" class="checkImg"></div>
			
		<label>Descripción:</label>
		<textarea rows="3" cols="20" name="desc" id="desc" tabindex="9" placeholder="Descripción de la tecnología"></textarea>
		<div id="desc_img" class="checkImg"></div>
	
		<div id="botones">
		<p><a href="javascript:void(0)" id="guardar" class="boton">Guardar</a></p>
		<p><a href="javascript:void(0)" id="cancelar" class="boton">Cancelar</a></p>
		</div>
	</form>
</div>

<div id="ventana">
	<span id="info"></span>
	<a href="javascript:void(0)" id="btnCerrarVentanaError" class="cerrarError">Cerrar</a>
</div>

<div id="seguroEliminar" title="ADVERTENCOA">
	<p>¿Seguro que desea eliminar este registro?</p>
	<a href="" id="siQuieroEliminar">Eliminar</a>
	<a href="" id="noQuieroEliminar">No</a>
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