package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clases.Query;
/**
 * Elimina el registro de un candidato
 * Servlet implementation class EliminarCandidato
 */
@WebServlet("/EliminarCandidato")
public class EliminarCandidato extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminarCandidato() { super(); }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idCandidato = Integer.parseInt(request.getParameter("idCandidato"));
		System.out.println("eliminar: "+idCandidato);
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		Query q = new Query();
		if(q.eliminarCandidato(idCandidato))
		{
			response.setStatus(HttpServletResponse.SC_OK);
			response.getWriter().write("El candidato se ha eliminado correctamente");
			System.out.println("El candidato se ha eliminado correctamente");
		}else
		{
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("No se pudo eliminar el registro del candidato");
			System.out.println("No se pudo eliminar el registro del candidato");
		}
		response.flushBuffer();
	}
}
