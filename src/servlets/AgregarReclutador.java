package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clases.Reclutador;
import clases.Query;

/**
 * Registro de un nuevo reclutador
 * Servlet implementation class AgregarReclutador
 */
@WebServlet("/AgregarReclutador")
public class AgregarReclutador extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AgregarReclutador() { super(); }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		Reclutador re = new Reclutador();
		re.setNombre(request.getParameter("nombre"));
		re.setPaterno(request.getParameter("paterno"));
		re.setMaterno(request.getParameter("materno"));
		re.setPass(request.getParameter("pass"));
		re.setUser(request.getParameter("user"));
		if(Integer.parseInt(request.getParameter("admin"))==1)
			re.setAdmin(true);
		else
			re.setAdmin(false);
		Query q = new Query();
		int res = q.insertarReclutador(re);
		switch(res)
		{
			case 1:
				response.setStatus(HttpServletResponse.SC_OK);
				response.getWriter().write("Reclutador registrado correctamente");
				response.flushBuffer();
				break;
			case 2:
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write("El nombre de usuario ya existe, debe elegir uno distinto");
				response.flushBuffer();
				break;
			case 3:
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write("Ha ocurrido un error inesperado, intente nuevamente");
				response.flushBuffer();
				break;
		}
	}
}
