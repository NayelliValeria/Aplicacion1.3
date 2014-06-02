package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clases.Candidato;
import clases.Query;
/**
 * Edita la información de un candidato
 * Servlet implementation class EditarCandidato
 */
@WebServlet("/EditarCandidato")
public class EditarCandidato extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditarCandidato() { super();}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sesion = request.getSession();
		Candidato ca  =new Candidato();
		System.out.println("reclu:" + sesion.getAttribute("nombreReclutador"));
		ca.setCurp(request.getParameter("curp"));
		ca.setRFC(request.getParameter("rfc"));
		ca.setNumero(request.getParameter("numero"));
		ca.setEmail(request.getParameter("email"));
		ca.setPalabras(request.getParameter("palabras"));
		ca.setTecnologia(request.getParameter("tecnologia"));
		ca.setNombre(request.getParameter("nombre"));
		ca.setPaterno(request.getParameter("apePaterno"));
		ca.setMaterno(request.getParameter("apeMaterno"));
		ca.setIdReclutador((int)sesion.getAttribute("idReclutador"));
		ca.setNombreReclutador((String)sesion.getAttribute("nombreReclutador"));
		ca.idCandidato = Integer.parseInt(request.getParameter("idCandidato"));
		Query q = new Query();
		q.editarCandidato(ca);
		if(q.editarCandidato(ca))
		 {
			response.setStatus(HttpServletResponse.SC_OK);
			System.out.println("Datos guardados correctamente.");
			response.getWriter().write("Los datos del candidato se han guardado correctamente.");
		    response.flushBuffer();
		 }else
		 {
			 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		     response.getWriter().write("Error al guardar los datos del candidato");
		     response.flushBuffer();
		 }
	}

}
