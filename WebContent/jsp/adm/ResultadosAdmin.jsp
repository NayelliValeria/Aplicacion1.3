<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="clases.Query" %>
<%@ page import="clases.Candidato" %>
<%@ page import="clases.Reclutador" %>
<%@ page import="clases.Tecnologia" %>
<%@ page import="java.util.ArrayList" %>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Candidatos Admin</title>
	<link rel="stylesheet" type="text/css" href="../../css/style.css">
	<link rel="stylesheet" type="text/css" href="../../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../../css/formulario.css">
	<link rel="stylesheet" type="text/css" href="../../css/jquery.dataTables.css">
	<script type="text/javascript" language="javascript" src="../../js/jquery.js"></script>
	<script type="text/javascript" language="javascript" src="../../js/jquery.dataTables.js"></script>
	<script type="text/javascript" language ="javascript" src="../../js/resultadosAdmin.js"></script>
	<script type="text/javascript" language ="javascript" src="../../js/validar.js"></script>
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
	ArrayList<Candidato> candidatos  = q.consultarCandidatosAdmin();
%>

<body>
<div id= "buscador">
		<p><a href="javascript:void(0)" id="nuevoRegistro" class="botonMenu2">Agregar candidato<img alt="" src="../../images/iconos/plus32.png"></a></p>
		<p><a href="javascript:void(0)" id="editar" class="botonMenu2">Editar candidato<img alt="" src="../../images/iconos/pencil32.png"></a></p>
		<p><a href="javascript:void(0)" id="eliminar" class="botonMenu2Ultimo">Eliminar candidato<img alt="" src="../../images/iconos/minus32.png"></a></p>
</div>
<div id="todo">
	<table class="display" id="resultadosAdmin">
		<thead>
			<tr>
			<th>Nombre</th>
			<th>Apellido Paterno</th>
			<th>Apellido Materno</th>
			<th>CURP</th>
			<th>RFC</th>
			<th>E-mail</th>
			<th>Teléfono</th>
			<th>Tecnología</th>
			<th>Palabras Clave</th>
			<th>Fecha</th>
			<th>Reclutador</th>
			<th id="id_candidato">id_candidato</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(int i=0; i<candidatos.size(); i++)
			{
				Candidato ca =  candidatos.get(i);
			%>
			<tr>
				<td><%=ca.getNombre() %></td>
				<td><%=ca.getPaterno() %></td>
				<td><%=ca.getMaterno() %></td>
				<td><%=ca.getCurp() %></td>
				<td><%=ca.getRFC() %></td>
				<td><%=ca.getEmail() %></td>
				<td><%=ca.getNumero() %></td>
				<td><%=q.obtenerTecnologiasCandidatoStrng(ca.idCandidato)%></td>
				<td><%=ca.getPalabras() %></td>
				<td><%=ca.getFechaRegistro() %></td>
				<td><%=ca.getNombreReclutador() %></td>
				<td id="id_candidato"><%=ca.idCandidato %></td>
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
			<th>CURP</th>
			<th>RFC</th>
			<th>E-mail</th>
			<th>Teléfono</th>
			<th>Tecnología</th>
			<th>Palabras Clave</th>
			<th>Fecha</th>
			<th>Reclutador</th>
			<th>id_candidato</th>
		</tr>
	</tfoot>
	</table>
	<span id="informe"></span>
	</div>
	
	<div id="editarCandidato" title="Editar Candidato">
	<span id="validacion"></span>
	<form action="" name ="form" method="POST" class="nuevoCandidato">
		<div id="izq">
			<label>CURP:</label>
			<input type="text" name="curp" id="curpEditar" onkeyup="javascript:aMayusculas(this)" tabindex="1" placeholder="CURP del candidato" readonly>
			<div id="curp_img" class="checkImg"></div>
			<div id="curpExistente">CURP registrado previamente.<a href="javascript:void(0)" id="detalles" class="boton">Mostrar detalles</a></div>
				
			<label>Apellido Paterno:</label>
			<input type="text" name="paterno" id="paterno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="3" placeholder="Apellido paterno">
			<div id="paterno_img" class="checkImg"></div>
						
			<label>E-mail:</label>
			<input type="email" name="email" id="email" onblur="javascript:aMinusculas(this)" tabindex="5" placeholder="e-mail del candidato">
			<div id="email_img" class="checkImg"></div>
			
			<label>RFC:</label>
			<input type="text" name="rfc" id="rfc" onblur="javascript:aMayusculas(this)" tabindex="7" placeholder="RFC del candidato">
			<div id="rfc_img" class="checkImg"></div>
			
			<label>Palabras clave:</label><br>
			<textarea rows="3" cols="20" name="palabras" id="palabras" tabindex="9" placeholder="Palabras clave del candidato"></textarea>
			<div id="palabras_img" class="checkImg"></div>
		</div>
		<div id="der">
			<label>Nombre:</label>
			<input type="text" name="nombre" id="nombre" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="2" placeholder="Nombre(s)">
			<div id="nombre_img" class="checkImg"></div>
			
			<label>Apellido Materno:</label>
			<input type="text" name="materno" id="materno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="4" placeholder="Apellido materno">
			<div id="materno_img" class="checkImg"></div>
			
			<label>Teléfono:</label>
			<input type="text" name="telefono" id="telefono" onblur="javascript:mascaraTelefono(this)" tabindex="6" placeholder="Teléfono">
			<div id="telefono_img" class="checkImg"></div>
			
			<label>Tecnología:</label><br>
			<div id="tecnologiaEditar">
				<%
				ArrayList<Tecnologia> tec  = q.buscarTecnologias();
				if(tec!=null)
					for(int i=0; i<tec.size(); i++)
					{
						Tecnologia te =  tec.get(i);
					%>
					<input type="checkbox" name="tec" value="<%=te.getId() %>" /> <%=te.getNombre() %> <br />
					<%
					}
				%>
			</div>
			<div id="tecnologia_img" class="checkImg"></div>
		</div>
		
		
		<div id="botones">
		<p><a href="javascript:void(0)" id="btnEditar" class="boton">Guardar</a></p>
		<p><a href="javascript:void(0)" id="btnCancelar" class="boton">Cancelar</a></p>
		</div>
	</form>
	</div>
	
	<div id="ventana">
	<span id="info"></span>
	<p><a href="javascript:void(0)" id="btnCerrarVentanaError" class="cerrarError">Cerrar</a></p>
	</div>
	
	<div id="error" title="ERROR">
	<p>Error: Por favor, seleccione un registro.</p>
	</div>
	
	<div id="seguroEliminar" title="ADVERTENCOA">
	<p>¿Seguro que desea eliminar este registro?</p>
	<a href="" id="siQuieroEliminar">Eliminar</a>
	<a href="" id="noQuieroEliminar">No</a>
	</div>
</body>
</html>