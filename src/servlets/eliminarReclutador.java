package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clases.Query;
/**
 * Servlet implementation class eliminarReclutador
 */
@WebServlet("/eliminarReclutador")
public class eliminarReclutador extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public eliminarReclutador() { super(); }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		int idRe = Integer.parseInt(request.getParameter("idReclutador"));
		Query q = new Query();
		if(q.eliminarReclutador(idRe))
		 {
			System.out.println("true");
			response.setStatus(HttpServletResponse.SC_OK);
			response.getWriter().write("El reclutador ha sido eliminado exitosamente");
			response.flushBuffer();
			System.out.println("Status code: " + response.getStatus() );
		 }else
		 {
			 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			 System.out.println("false");
			 response.getWriter().write("El reclutador no puede ser eliminado debido a que tiene candidatos registrados.");
			 response.flushBuffer();
		     System.out.println("Status code: " + response.getStatus() );
		 }
	}
}
