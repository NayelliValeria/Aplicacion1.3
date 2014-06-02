package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clases.Candidato;
import clases.Tecnologia;
import clases.Query;

/**
 * Registro de un nuevo candidato
 * Servlet implementation class NuevoCandidato
 */
@WebServlet("/AgregarCandidato")
public class AgregarCandidato extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AgregarCandidato(){ super(); }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		Candidato ca  =new Candidato();
		ca.setCurp(request.getParameter("curp"));
		ca.setRFC(request.getParameter("rfc"));
		ca.setNumero(request.getParameter("numero"));
		ca.setEmail(request.getParameter("email"));
		ca.setPalabras(request.getParameter("palabras"));
		ca.setTecnologia(request.getParameter("tecnologia"));
		ca.setNombre(request.getParameter("nombre"));
		ca.setPaterno(request.getParameter("paterno"));
		ca.setMaterno(request.getParameter("materno"));
		Query q = new Query();
		
		if(q.insertarCandidato(ca, Integer.parseInt(request.getSession().getAttribute("idReclutador").toString()) ))
		{
			response.setStatus(HttpServletResponse.SC_OK);
			response.getWriter().write("Candidato registrado correctamente.");
		}
		else
		{
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("Error al registrar candidato.");
			//response.flushBuffer();
			System.out.println("Error al registrar candidato.");
		}
		response.flushBuffer();
	}
}
