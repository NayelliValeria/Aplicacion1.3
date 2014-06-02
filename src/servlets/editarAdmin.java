package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clases.Query;
import clases.Reclutador;

/**
 * Edita la informaciòn del administrador
 * Servlet implementation class editarAdmin
 */
@WebServlet("/editarAdmin")
public class editarAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editarAdmin() { super(); }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("En editar admin");
		int idReclutador = (int)(request.getSession().getAttribute("idReclutador"));
		String accion = (request.getParameter("accion")).toString();
		Query q = new Query();
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		if(accion.equalsIgnoreCase("nombres"))
		{
			boolean re = q.editarNombredAdmin(idReclutador, request.getParameter("nombre"), request.getParameter("paterno"), request.getParameter("materno"));
			 if(re==false)
			 { 
				 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			     response.getWriter().write("Error: los datos no se pudieron actualizar.");
			     response.flushBuffer();
			 }else
			 {
				 request.getSession().setAttribute("idReclutador", idReclutador);
				 Reclutador r = (Reclutador)request.getSession().getAttribute("reclutador");
				 r.setMaterno(request.getParameter("materno"));
				 r.setPaterno(request.getParameter("paterno"));
				 r.setNombre(request.getParameter("nombre"));
				 request.getSession().setAttribute("reclutador", r);
				 response.getWriter().write("Su datos han sido actualizados.");
			}
		}else
		{
			boolean re = q.editarPasswordAdmin(idReclutador, request.getParameter("pass"), request.getParameter("passActual"));
			 if(re==false)
			 { 
				 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			     response.getWriter().write("Error: los datos no se pudieron actualizar.");
			     response.flushBuffer();
			 }else
			 {
				 request.getSession().setAttribute("idReclutador", idReclutador);
				// Reclutador r = (Reclutador)request.getSession().getAttribute("reclutador");
				 response.getWriter().write("Su contraseña ha sido actualizada.");
			}
		}
	}
}	
