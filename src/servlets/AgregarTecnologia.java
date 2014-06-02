package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clases.Tecnologia;
import clases.Query;

/**
 * Servlet implementation class AgregarTecnologia
 */
@WebServlet("/AgregarTecnologia")
public class AgregarTecnologia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AgregarTecnologia() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		Tecnologia te  =new Tecnologia();
		int accion = Integer.parseInt(request.getParameter("editar"));
		System.out.println("Accion:"+accion);
		te.setNombre(request.getParameter("nombre"));
		te.setDescripcion(request.getParameter("descripcion"));
		if(accion==1)//Editar
		{
			te.setId(Integer.parseInt(request.getParameter("id")));
			System.out.println("Editando "+ te.getId() +"-"+te.getNombre()+"-"+te.getDescripcion());
			Query q = new Query();
			if(q.editarTecnologia(te, te.getId()))
			{
				response.setStatus(HttpServletResponse.SC_OK);
				response.getWriter().write("Tecnología guardada correctamente.");
			}
			else
			{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write("Error al guardar tecnología.");
				System.out.println("Error al editar tecnología.");
			}
		}
		//Agregar
		if(accion==0){
			Query q = new Query();
			if(q.insertarTecnologia(te))
			{
				response.setStatus(HttpServletResponse.SC_OK);
				response.getWriter().write("Tecnología guardada correctamente.");
			}
			else
			{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write("Error al guardar tecnología.");
				System.out.println("Error al guardar tecnología.");
			}
		}
		//Eliminar
		if(accion==2){
			Query q = new Query();
			int id=Integer.parseInt(request.getParameter("id"));
			System.out.println("Eliminar: "+id);
			if(q.eliminarTecnologia(id))
			{
				response.setStatus(HttpServletResponse.SC_OK);
				response.getWriter().write("Tecnología eliminada correctamente.");
			}
			else
			{
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				response.getWriter().write("Error al eliminar tecnología.");
				System.out.println("Error al eliminar tecnología.");
			}
		}
		//Regresa tecnologias del candidato
		if(accion==3){
			Query q = new Query();
			ArrayList<Tecnologia> tecs=  q.obtenerTecnologiasCandidato(Integer.parseInt(request.getParameter("idCandidato")));
			if(tecs!=null)
			{
				String r = "";
				for (int i = 0; i < tecs.size(); i++) {
					r+=tecs.get(i).getId()+",";
				}
				System.out.println(r + "idCan" + Integer.parseInt(request.getParameter("idCandidato")));
				response.setStatus(HttpServletResponse.SC_OK);
				response.getWriter().write(r);
			}
			else
			{
				System.out.println("No hay tecnologias registradas.");
			}
		}
		response.flushBuffer();
	}
}
