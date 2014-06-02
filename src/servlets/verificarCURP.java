package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clases.Query;
import clases.Candidato;
import clases.Reclutador;
/**
 * Verifica la existencia de un CURP
 * Servlet implementation class verificarCURP
 */
@WebServlet("/verificarCURP")
public class verificarCURP extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public verificarCURP() { super(); }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		try
		{
			String curp = request.getParameter("curp");
			Query q = new Query();
			int idRe = q.verificarCURP(curp);
			System.out.println("idreclutador: " + idRe);
			if(idRe == 0)//No se encontró
			{
				response.getWriter().write("1");//Entonces es valido
			}
			else
			{
				Candidato ca = q.buscarCandidato(curp);
				Reclutador re = q.consultarReclutador(idRe);
				response.getWriter().write("Candidato: " + ca.getNombre() + " " + ca.getPaterno() + " " +ca.getMaterno()
						+"<br>" + "E-mail: " + ca.getEmail() 
						+"<br>" + "Registrado por:" + re.getNombre() + " " + re.getPaterno() + " " +re.getMaterno()
						+"<br>" + "el día: " + ca.getFechaRegistro());
			}
			response.flushBuffer();
		}catch(Exception e)
		{
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		    response.getWriter().write("Ha ocurrido un error, intente nuevamente." + e);
		    response.flushBuffer();
		}
	}

}
