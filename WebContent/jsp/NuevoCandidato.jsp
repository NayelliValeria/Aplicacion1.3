<%@page import="clases.Reclutador"%>
<%@page import="clases.Query"%>
<%@page import="clases.Tecnologia"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
%>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="../css/style.css">
	<link rel="stylesheet" type="text/css" href="../css/menu.css">
	<link rel="stylesheet" type="text/css" href="../css/jquery.dataTables.css">
	<link rel="stylesheet" type="text/css" href="../css/formulario.css">
	
	<script type="text/javascript" language ="javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" language ="javascript" src="../js/validar.js"></script>
	<script type="text/javascript" language ="javascript" src="../js/nuevoCandidato.js"></script>
</head>

<body>
<div id= "buscador">
	<p><a href="javascript:void(0)" id="consultar" class="botonMenu2">Consultar candidatos<img alt="" src="../images/iconos/pencil32.png"></a></p>
</div>
<div id="todo">
<span id="validacion"></span>
	<form action="/Aplicacion1.3/AgregarCandidato" name ="form" method="POST" class="nuevoCandidato">
		<div id="izq">
			<label>CURP:</label>
			<input type="text" name="curp" id="curp" onkeyup="javascript:aMayusculas(this)" tabindex="1" placeholder="CURP del candidato">
			<div id="curp_img" class="checkImg"></div>
			<div id="curpExistente">CURP registrado previamente.<a href="javascript:void(0)" id="detalles" class="boton">Mostrar detalles</a></div>
				
			<label>Apellido Paterno:</label>
			<input type="text" name="paterno" id="paterno" maxlength="20" onblur="javascript:aMayusculas(this)" tabindex="3" placeholder="Apellido paterno">
			<div id="paterno_img" class="checkImg"></div>
						
			<label>E-mail:</label>
			<input type="email" name="email" id="email" onblur="javascript:aMinusculas(this)" tabindex="5" placeholder="e-mail del candidato">
			<div id="email_img" class="checkImg"></div>
			
			<label>RFC :</label>
			<input type="text" name="rfc" id="rfc" onblur="javascript:aMayusculas(this)" tabindex="7" placeholder="RFC del candidato">
			<div id="rfc_img" class="checkImg"></div>
						
			<label>Palabras clave:</label>
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
			<div id="tecnologia">
				<%
				Query q =  new Query();
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
		<p><a href="javascript:void(0)" id="agregar" class="boton">Agregar</a></p>
		<p><a href="javascript:void(0)" id="cancelar" class="boton">Cancelar</a></p>
		
		</div>
	</form>
</div>
<div id="ventana">
	<span id="info"></span>
	<a href="javascript:void(0)" id="btnCerrarVentanaError" class="cerrarError">Cerrar</a>
</div>

</body>
</html>