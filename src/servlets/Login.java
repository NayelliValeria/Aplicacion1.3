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
 * Inicio de sesión a la aplicación
 * Cambio de usuario y/o contraseña de reclutadores
 * Servlet implementation class Login
 */
@WebServlet(description = "Recibe datos de login", urlPatterns = { "/Login" })
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() { super(); }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("En Login");
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		//Editar password y datos de los reclutadores
		if( request.getParameter("pass2") != null)
		{
			System.out.println("En editar pass");
			int idReclutador = (int)(request.getSession().getAttribute("idReclutador"));
			Query q = new Query();
			boolean re = q.editarSesionReclutador(idReclutador, request.getParameter("pass"), request.getParameter("passActual"));
			 if(re==false)
			 { 
				 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			     response.getWriter().write("Error: los datos no se pudieron actualizar, intente nuevamente.");
			     response.flushBuffer();
			 }else
			 {
				 response.setStatus(HttpServletResponse.SC_OK);
				 request.getSession().setAttribute("idReclutador", idReclutador);
				 response.getWriter().write("Su contraseña ha sido actualizada.");
			 }
		}else{
			//Inicio de sesión
			String user = request.getParameter("user");
			String pass = request.getParameter("pass");
			Query q = new Query();
			Reclutador re = q.iniciarSesion(user, pass);
			 if(re==null)
			 {
				 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			     response.getWriter().write("Usuario y/o contraseña incorrectos.");
			     response.flushBuffer();
			 }else
			 {
				 request.getSession().setAttribute("reclutador", re);
				 request.getSession().setAttribute("idReclutador", re.idReclutador);
				 if(re.getAdmin())
				 {
					System.out.println("Sesión de administrador");
					request.getSession().setAttribute("Admin", true);
				 }
				 else
				 {
					 System.out.println("Sesión de reclutador");
					 request.getSession().setAttribute("Admin", false);
				 }
			 }
		}
	}
}
