package servlets;

import java.io.IOException;
import clases.Reclutador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clases.Query;

/**
 * Edita la informaciòn del reclutador -  de administrador
 * Servlet implementation class editarReclutador
 */
@WebServlet("/editarReclutador")
public class editarReclutador extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public editarReclutador() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("editando reclutador");
		Reclutador re  =new Reclutador();
		re.setNombre(request.getParameter("nombre"));
		re.setPaterno(request.getParameter("apePaterno"));
		re.setMaterno(request.getParameter("apeMaterno"));
		re.setPass(request.getParameter("pass"));
		re.setUser(request.getParameter("user"));
		if(Integer.parseInt(request.getParameter("admin"))==1)
			re.setAdmin(true);
		else
			re.setAdmin(false);
		re.idReclutador = Integer.parseInt(request.getParameter("idReclutador"));
		Query q = new Query();
		if(q.editarReclutador(re))
		 {
			//request.getSession().setAttribute("reclutador", re);
			response.setStatus(HttpServletResponse.SC_OK);
		     response.getWriter().write("Los datos del reclutador se han guardado correctamente.");
		     response.flushBuffer();
		 }else
		 {
			 response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		     response.getWriter().write("Error al realizar la guardar los datos del reclutador.");
		     response.flushBuffer();
		 }
	}

}
