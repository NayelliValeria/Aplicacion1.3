package clases;

/**
 * Esta clase contiene los accesos de la aplicación a la base de datos
 * @author Nayelli Valeria PC - recluIT
 * @version 1.0 marzo2014
 * 
 */

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class Query {
	private Connection connection;
	private Conexion conexion;
	
	/**
	 * Constructor
	 * @param c Objeto de tipo Conexion
	 */
	public Query(Conexion c){
		conexion = c;
	}
	
	/**
	 * Constructor
	 */
	public Query(){
		conexion = new Conexion();
	}
	
	/**
	 * Busca en la base de datos, el usuario y contraseña
	 * adecuados para el inicio de sesión
	 * @param user nombre de usuario
	 * @param pass contraseña
	 * @return objeto de tipo Reclutador (el que inicia sesión), NULL si contraseña y/o usuario son incorrectos
	 */
	public Reclutador iniciarSesion( String user, String pass)
	{
		try
		{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Inicio de sesión "+ user);
			Reclutador re = new Reclutador(user,pass);
			connection = conexion.conectar();
			int admin = 0;
			String sql = "SELECT Reclutador.idReclutador, Reclutador.Admin, Persona.nombre, Persona.ApePaterno, Persona.ApeMaterno from Reclutador,Persona WHERE BINARY Reclutador.Usuario =\"" + user + "\" and BINARY Reclutador.Password = \"" + pass + "\" and Persona.idPersona = Reclutador.Persona_idPersona" ;
			PreparedStatement stm = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery(sql);
			while(rs.next())
				{
					re.nombre = rs.getString("Nombre");
					re.apePaterno = rs.getString("ApePaterno");
					re.apeMaterno = rs.getString("ApeMaterno");
					re.idReclutador = Integer.parseInt(rs.getString("idReclutador"));
					admin = Integer.parseInt(rs.getString("Admin"));
				}
			if(admin == 0)
				re.setAdmin(false);
			else
				re.setAdmin(true);
			connection.close();
			if(re.apePaterno==null)
				return null;
			else
				return re;
		} catch (SQLException e){
			System.out.println("Ha ocurrido un error en la consulta SQL." + e.getMessage());
			return null;
		}
	}
	
	/**
	 * Registra un nuevo candidato en la base de datos
	 * @param ca Objeto de tipo candidato
	 * @param idReclutador el identificador del reclutador que lo registra
	 * @return true si se registró correctamente, false en caso contrario
	 */
	public boolean insertarCandidato(Candidato ca, int idReclutador)
	{
		try
		{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Registrar candidato: "+ ca.nombre + ", idReclu:" + idReclutador);
			connection = conexion.conectar();
			/*String sql = "call NuevoCandidato(\""+ca.nombre+ "\",\""+ca.apePaterno+"\",\""+ ca.apeMaterno+"\",\""+ca.getCurp()+"\",\""+ca.getRFC()+"\",\""+ca.getEmail()+"\",\""+ca.getNumero()+"\",\""+ca.getTecnologia()+"\",\""+ca.getPalabras()+"\",\""+idReclutador +"\")" ;
			PreparedStatement stm = connection.prepareStatement(sql);
			stm.execute(sql);
			*/
			String sql ="{call NuevoCandidato(?,?,?,?,?,?,?,?,?,?,?)}";
			java.sql.CallableStatement rs = connection.prepareCall(sql);
			rs.setString(1, ca.nombre);
			rs.setString(2, ca.apePaterno);
			rs.setString(3, ca.apeMaterno);
			rs.setString(4, ca.getCurp());
			rs.setString(5, ca.getRFC());
			rs.setString(6, ca.getEmail());
			rs.setString(7, ca.getNumero());
			rs.setString(8, ca.getTecnologia());
			rs.setString(9, ca.getPalabras());
			rs.setInt(10, idReclutador);
			rs.registerOutParameter(11, java.sql.Types.INTEGER);
			rs.executeUpdate();
			int res = rs.getInt("idCan");
			if(insertarTecnologias(ca.getTecnologia(), res))
				return true;
			else
				return false;
		} catch (SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL al registrar." + e.getMessage());
			return false;
		}
	}
	
	/**
	 * Edita los datos de un candidato
	 * @param ca objeto de tipo candidato
	 * @return true si se editó correctamente, false en caso contrario
	 */
	public boolean editarCandidato(Candidato ca)
	{
		try
		{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Editar candidato "+ ca.nombre);
			connection = conexion.conectar();
			String sql = "call editarCandidato("+ca.idCandidato+",'"+ca.nombre+"','"+ca.apePaterno+"','"+ca.apeMaterno+"','"+ca.getCurp()+"','"+ca.getRFC()+"','"+ca.getEmail()+"','"+ca.getNumero()+"','"+ca.getTecnologia()+"','"+ca.getPalabras()+"',"+ca.getIdReclutador()+")" ;
			PreparedStatement stm = connection.prepareStatement(sql);
			stm.execute(sql);
			eliminarTecnologias(ca.idCandidato);
			if(insertarTecnologias(ca.getTecnologia(), ca.idCandidato))
				return true;
			else
				return false;
		} catch (SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al actualizar" + e.getMessage());
			return false;
		}
	}
	
	/**
	 * Edita los datos de un reclutador
	 * Solo por administrador
	 * @param re objeto de tipo reclutador
	 * @return true si se editó correctamente, false en caso contrario
	 */
	public boolean editarReclutador( Reclutador re)
	{
		try
		{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Editar reclutador "+ re.nombre);
			connection = conexion.conectar();
			int admin=0;
			if(re.getAdmin())
				admin=1;
			String sql = "call editarReclutador("+re.idReclutador+",'"+re.nombre+"','"+re.apePaterno+"','"+re.apeMaterno+"','"+re.getPass()+"','"+re.getUser()+"',"+admin+")" ;
			PreparedStatement stm = connection.prepareStatement(sql);
			stm.execute(sql);
			return true;
		} catch (SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al actualizar" + e.getMessage());
			return false;
		}
	}
	
	/**
	 * Consulta todos los candidatos registrados por un reclutador
	 * @param idReclutador el identificador del reclutador
	 * @return ArrayList de objetos tipo Candidato
	 */
	public ArrayList<Candidato> consultarCandidatos(int idReclutador)
	{
		try
		{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Consulta de candidatos por idReclu:"+idReclutador);
			ArrayList<Candidato> c =  new ArrayList<Candidato>();
			connection = conexion.conectar();
			String sql = "call ConsultarCandidatos(\""+ idReclutador +"\")";
			PreparedStatement stm = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery(sql);
			System.out.println("consultando cnadidatos");
			while(rs.next())
			{
				Candidato ca = new Candidato(
						rs.getString("NombreCandidato"),
						rs.getString("ApePaternoCandidato"),
						rs.getString("ApeMaternoCandidato"),
						rs.getString("CURP"),
						rs.getString("RFC"),
						rs.getString("Telefono"),
						rs.getString("Email"),
						rs.getString("PalabrasClave"),
						rs.getString("Tecnologia"),
						rs.getInt("Reclutador_idReclutador"),
						rs.getString("nombreReclutador")+" "+rs.getString("ApePaternoReclutador")+" "+rs.getString("ApeMaternoReclutador"),
						new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("Fecha"))
						);
				ca.idCandidato = rs.getInt("idCandidato");
				c.add(ca);
			}
			return c;
		}catch(SQLException e)
		{
			System.out.println("Error al consultar" + e.getMessage());
			return null;
		}
	}
	
	/**
	 * Consulta los candidatos registrados por todos los reclutadores
	 * Esta función sólo debe usarla el administrador
	 * @return ArrayList de objetos tipo Candidato
	 */
	public ArrayList<Candidato> consultarCandidatosAdmin()
	{
		try
		{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Consulta de candidatos por el administrador");
			ArrayList<Candidato> c =  new ArrayList<Candidato>();
			connection = conexion.conectar();
			String sql = "call ConsultarCandidatosAdmin()";
			PreparedStatement stm = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery(sql);
			while(rs.next())
			{
				Candidato ca = new Candidato(
						rs.getString("NombreCandidato"),
						rs.getString("ApePaternoCandidato"),
						rs.getString("ApeMaternoCandidato"),
						rs.getString("CURP"),
						rs.getString("RFC"),
						rs.getString("Telefono"),
						rs.getString("Email"),
						rs.getString("PalabrasClave"),
						rs.getString("Tecnologia"),
						rs.getInt("Reclutador_idReclutador"),
						rs.getString("nombreReclutador")+" "+rs.getString("ApePaternoReclutador")+" "+rs.getString("ApeMaternoReclutador"),
						new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("Fecha"))
						);
				ca.idCandidato = rs.getInt("idCandidato");
				c.add(ca);
			}
			return c;
		}catch(SQLException e)
		{
			System.out.println("Error al consultar" + e.getMessage());
			return null;
		}
	}
	
	/**
	 * Elimina el registro de un candidato
	 * @param id identificador del candidato a eliminar
	 * @return true si se eliminó correctamente, false en caso contrario
	 */
	public boolean eliminarCandidato(int id)
	{
		try
		{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Eliminar candidato id:"+id);
			eliminarTecnologias(id);
			connection = conexion.conectar();
			String sql ="call EliminarCandidato(\""+id+"\")";
			PreparedStatement stm = connection.prepareStatement(sql);
			stm.executeUpdate(sql);
			return true;
		}catch(SQLException e){
			System.out.println("Error al eliminar al candidato" + id + "\n\n" + e.getMessage());
			return false;
		}
	}
	
	/**
	 * Elimina el registro de un Reclutador
	 * Sólo administrador
	 * @param id identificador del Reclutador a eliminar
	 * @return true si se eliminó correctamente, false en caso contrario
	 */
	public boolean eliminarReclutador(int id)
	{
		try
		{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Eliminar reclutador id: "+ id);
			connection = conexion.conectar();
			int res = 0;
			String sql ="{call EliminarReclutador(?,?)}";
			java.sql.CallableStatement rs = connection.prepareCall(sql);
			rs.setInt(2, id);
			rs.registerOutParameter(1, java.sql.Types.INTEGER);
			rs.executeUpdate();
			res = rs.getInt(1);
			System.out.println("res = " + res);
			if(res==0)
				return false;
			else
				return true;
		}catch(SQLException e){
			System.out.println("Error al eliminar al candidato" + id + "\n\n" + e.getMessage());
			return false;
		}
	} 
	
	/**
	 * Consulta el registro de un candidato por su CURP
	 * @param curp el curp del candidato
	 * @return objeto de tipo Candidato si lo ha encontrado, NULL en caso contrario
	 */
	public Candidato buscarCandidato(String curp)
	{
		try{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Buscar candidato por CURP "+ curp);
			connection  = conexion.conectar();
			String sql = "call consultaCandidato(\""+ curp +"\")";
			PreparedStatement stm = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery();
			Candidato ca = null;
			while(rs.next())
			{
				ca = new Candidato(
						rs.getString("Nombre"),
						rs.getString("ApePaterno"),
						rs.getString("ApeMaterno"),
						rs.getString("CURP"),
						rs.getString("RFC"),
						rs.getString("Telefono"),
						rs.getString("Email"),
						rs.getString("PalabrasClave"),
						rs.getString("Tecnologia"),
						0,
						rs.getString("nombreR")+" "+rs.getString("ApePaternoR")+" "+rs.getString("ApeMaternoR"),
						rs.getString("Fecha")
						);
			}
			return ca;
		}catch(SQLException e )
		{ 
			System.out.println("Error" + e.getMessage());
			return null;
		}
	}
	
	/**
	 * Verifica si existe un CURP
	 * @param curp el CURP a verificar
	 * @return 0  si no existe, un número mayor a 0 si existe
	 */
	public int verificarCURP(String curp)
	{
		try{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Verificar curp: "+ curp);
			connection  = conexion.conectar();
			String sql = "call verificarCurp(\""+ curp +"\")";
			PreparedStatement stm = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery();
			int idReclutador =0;
			while(rs.next())
			{
				idReclutador = rs.getInt(1);
			}

			return idReclutador;
			
		}catch(SQLException e )
		{ 
			System.out.println("Error" + e.getMessage());
			return 0;
		}
	}
	
	/**
	 * Consulta los datos de un reclutador
	 * @param idRe el identificador del reclutador a consultar
	 * @return objeto de tipo Reclutador si l oha encontrado, NULL en caso contrario
	 */
	public Reclutador consultarReclutador(int idRe)
	{
		Reclutador re = new Reclutador();
		try{
			SimpleDateFormat tiempo =  new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date fecha = new Date();
			System.out.println(tiempo.format(fecha) + "Consultar reclutador id:"+ idRe);
			connection  = conexion.conectar();
			String sql = "call consultarReclutador(\""+ idRe +"\")";
			PreparedStatement stm = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery();
			while(rs.next())
			{
				re.setNombre(rs.getString("Nombre"));
				re.setMaterno(rs.getString("ApeMaterno"));
				re.setPaterno(rs.getString("ApePaterno"));
			}

			if(re.nombre==null)
				return null;
			else
				return re;
			
		}catch(SQLException e )
		{ 
			System.out.println("Error" + e.getMessage());
			return null;
		}
	}
	
	/**
	 * Actualiza la contraseña de un reclutador
	 * @param idReclutador el identificador del reclutador a actualizar
	 * @param pass la nueva contraseña
	 * @param passActual la contraseña anterior
	 * @return
	 */
	public boolean editarSesionReclutador(int idReclutador, String pass, String passActual)
	{
		try
		{
			connection = conexion.conectar();
			int res = 0;
			String sql = "{call editarSesionReclutador(?,?,?,?)}";
			java.sql.CallableStatement rs = connection.prepareCall(sql);
			rs.setInt(1, idReclutador);
			rs.setString(2, pass);
			rs.setString(3, passActual);
			rs.registerOutParameter(4, java.sql.Types.INTEGER);
			rs.executeQuery();
			res = rs.getInt(4);
			System.out.println("res = " + res);
			if(res<=0)
				return false;
			else
				return true;
		} catch (SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al actualizar" + e.getMessage());
			return false;
		}
	}
	
	/**
	 * Registra un nuevo reclutador
	 * @param re objeto de tipo reclutador, con los datos a registrar
	 * @return true si se registró correctamente, false en caso contrario
	 */
	public int insertarReclutador(Reclutador re)
	{
		try
		{
			connection = conexion.conectar();
			int admin=0;
			if(re.getAdmin())
				admin=1;
			String sql = "call buscarUsuario(\""+re.getUser()+"\")" ;
			PreparedStatement stm = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery(sql);
			while(rs.next())
				if(rs.getInt(1)>0)
					return 2;
			sql = "call NuevoReclutador(\""+re.nombre+ "\",\""+re.apePaterno+"\",\""+ re.apeMaterno+"\",\""+re.getUser()+"\",\""+re.getPass() +"\","+admin+")" ;
			stm = connection.prepareStatement(sql);
			stm.execute(sql);
			return 1;
		} catch (SQLException e)
		{
			System.out.println("Ha ocurrido un error al registrar al Reclutador." + e.getMessage());
			return 3;
		}
	}
	
	/**
	 * Consulta todos los reclutadores registrados
	 * Esta función sólo debe ser usada por el administrador
	 * @return ArrayList de objetos Reclutador
	 */
	public ArrayList<Reclutador> consultarReclutadoresAdmin()
	{
		try
		{
			ArrayList<Reclutador> c =  new ArrayList<Reclutador>();
			connection = conexion.conectar();
			String sql = "call ConsultarReclutadores()";
			PreparedStatement stm = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery(sql);
			while(rs.next())
			{
				Reclutador re = new Reclutador(
						rs.getString("Nombre"),
						rs.getString("ApePaterno"),
						rs.getString("ApeMaterno"),
						rs.getString("Usuario"),
						rs.getString("Password")
						);
				if(Integer.parseInt(rs.getString("Admin"))==1)
					re.setAdmin(true);
				else
					re.setAdmin(false);
				re.idReclutador = rs.getInt("idReclutador");
				c.add(re);
			}
			return c;
		}catch(SQLException e)
		{
			System.out.println("Error al consultar reclutadores" + e.getMessage());
			return null;
		}
	}
	
	/**
	 * Actualiza la contraseña del administrador
	 * @param idReclutador identificador del administrador
	 * @param pass nueva contraseña
	 * @param passActual contraseña actual
	 * @return true si se actualizó correctamente, false en caso contrario
	 */
	public boolean editarPasswordAdmin(int idReclutador, String pass, String passActual)
	{
		try
		{
			connection = conexion.conectar();
			int res = 0;
			String sql ="{call editarPassAdmin(?,?,?,?)}";
			java.sql.CallableStatement rs = connection.prepareCall(sql);
			rs.setInt(1, idReclutador);
			rs.setString(2, pass);
			rs.setString(3, passActual);
			rs.registerOutParameter(4, java.sql.Types.INTEGER);
			rs.executeUpdate();
			res = rs.getInt(4);
			System.out.println("res = " + res);
			if(res==0)
				return false;
			else
				return true;
		} catch (SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al actualizar" + e.getMessage());
			return false;
		}
	}
	
	/**
	 * Actualiza los datos  del administrador
	 * @param idReclutador identificador del administrador
	 * @param no Nombre  del administrador
	 * @param pa apellido paterno del administrador
	 * @param ma apellido materno del administrador
	 * @return true si se actualizó correctamente, false en caso contrario
	 */
	public boolean editarNombredAdmin(int idReclutador, String no, String pa, String ma)
	{
		try
		{
			connection = conexion.conectar();
			String sql = "call editarNombreAdmin("+ idReclutador +",'"+ no+ "','"+ pa + "','"+ ma + "')" ;
			PreparedStatement stm = connection.prepareStatement(sql);
			stm.execute(sql);
			return true;
		} catch (SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al actualizar" + e.getMessage());
			return false;
		}
	}
	
	/**Busca tecnologias Registradas**/
	public ArrayList<Tecnologia> buscarTecnologias()
	{
		ArrayList<Tecnologia> tecs = new ArrayList<Tecnologia>();
		try
		{
			connection = conexion.conectar();
			String sql = "Select * from tecnologia order by nombreTecnologia";
			PreparedStatement  stm  = connection.prepareStatement(sql);
			ResultSet  rs = stm.executeQuery();
			while(rs.next())
			{
				tecs.add(new Tecnologia(rs.getInt("idTecnologia"),rs.getString("nombreTecnologia"),rs.getString("descripcionTecnologia")));
			}
			return tecs;
		}catch(SQLException e){
			System.out.println("Ha ocurrido un error SQL. al bucar tecnologias" + e.getMessage());
			return null;
		}
	}
	
	public boolean insertarTecnologia(Tecnologia te)
	{
		try{
			connection = conexion.conectar();
			String sql = "Insert into tecnologia values("+0+",+'"+te.getNombre()+"','"+te.getDescripcion()+"')";
			PreparedStatement  stm  = connection.prepareStatement(sql);
			stm.executeUpdate(sql);
			return true;
		}catch(SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al guardar tecnologias" + e.getMessage());
			return false;
		}
	}
	
	public boolean editarTecnologia(Tecnologia te, int id)
	{
		try
		{
			connection = conexion.conectar();
			String sql = "Update tecnologia set nombreTecnologia='"+te.getNombre()+"' , descripcionTecnologia='"+te.getDescripcion()+"' where idTecnologia="+id+"";
			PreparedStatement  stm  = connection.prepareStatement(sql);
			stm.executeUpdate(sql);
			return true;
		}catch(SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al editar tecnologias" + e.getMessage());
			return false;
		}
	}
	
	public boolean eliminarTecnologia(int id)
	{
		try
		{
			connection = conexion.conectar();
			String sql = "delete from tecnologia where idTecnologia="+id+"";
			PreparedStatement  stm  = connection.prepareStatement(sql);
			stm.executeUpdate(sql);
			return true;
		}catch(SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al eliminar tecnologias" + e.getMessage());
			return false;
		}
	}
	
	public  boolean insertarTecnologias(String tec, int id)
	{
		try
		{
			connection = conexion.conectar();
			String[] result = tec.split(",");
			for(String s : result)
			{
				String sql = "Insert into candidato_has_tecnologia values("+Integer.parseInt(s)+","+id+")";
				PreparedStatement  stm  = connection.prepareStatement(sql);
				stm.executeUpdate(sql);
			}
			return true;
		}catch(SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al insertar tecnologias" + e.getMessage());
			return false;
		}
	}
	
	public  boolean eliminarTecnologias(int id)
	{
		try
		{
			connection = conexion.conectar();
			String sql = "delete from candidato_has_tecnologia where idCandidato = "+id+"";
			PreparedStatement  stm  = connection.prepareStatement(sql);
			stm.executeUpdate(sql);
			return true;
		}catch(SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al eliminar tecnologias" + e.getMessage());
			return false;
		}
	}
	
	public ArrayList<Tecnologia> obtenerTecnologiasCandidato(int idCandidato)
	{
		ArrayList<Tecnologia> tecs = new ArrayList<Tecnologia>();
		try
		{
			connection = conexion.conectar();
			String sql = "select t.idTecnologia, t.nombreTecnologia, t.descripcionTecnologia from tecnologia as t, Candidato as c, candidato_has_tecnologia as tc where tc.idCandidato=c.idCandidato and t.idTecnologia=tc.idTecnologia and c.idCandidato ="+idCandidato;
			PreparedStatement  stm  = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery(sql);
			while(rs.next())	
			{
				tecs.add(new Tecnologia(rs.getInt(1), rs.getString(2),rs.getString(3)));
			}
			if(tecs.size()>0)
				return tecs;
			else
				return null;
		}catch(SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al buscar tecnologias" + e.getMessage());
			return null;
		}
	}
	
	public String obtenerTecnologiasCandidatoStrng(int idCandidato)
	{
		String tecnologias = "";
		try
		{
			connection = conexion.conectar();
			String sql = "select t.idTecnologia, t.nombreTecnologia, t.descripcionTecnologia from tecnologia as t, Candidato as c, candidato_has_tecnologia as tc where tc.idCandidato=c.idCandidato and t.idTecnologia=tc.idTecnologia and c.idCandidato ="+idCandidato;
			PreparedStatement  stm  = connection.prepareStatement(sql);
			ResultSet rs = stm.executeQuery(sql);
			while(rs.next())	
			{
				tecnologias+=rs.getString(2)+", ";
			}
			return tecnologias;
		}catch(SQLException e)
		{
			System.out.println("Ha ocurrido un error SQL. al buscar tecnologias" + e.getMessage());
			return null;
		}
	}
}
