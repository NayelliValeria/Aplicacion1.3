package clases;

/**
 * 
 * @author Nayelli Valeria PC - recluIT
 * @version 1.0 marzo2014
 * Esta clase describe la conexi�n de la aplicaci�n a la base de datos.
 * CMDB - Mysql 5.6
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion 
{	
	private static String URL;
	private static String user;
	private static String pass;
	private static Connection connection;
	
	/**
	 * Constructor que inicializa los par�metros
	 * @param URL es la url de la base de datos
	 * @param user es el usuario de la sesi�n mysql
	 * @param pass es la contrase�a de la sesi�n mysql
	 */
	Conexion()
	{
		URL = "jdbc:mysql://localhost:3306/mydb";
		user = "root";
		pass = "rootpass";
		//pass =  "pass";
	}
	
	@SuppressWarnings("finally")
	/**
	 * M�todo que ejecuta la conexi�n
	 * @return objeto Connection
	 * @throws SQLException
	 */
	public Connection conectar() throws SQLException
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection(URL, user, pass);
		}
		catch(ClassNotFoundException ex)
		{
		    System.out.println( "Error1 en la Conexi�n con la BD "+ex.getMessage());
		    connection=null;
		}
		catch(SQLException ex)
		{
			System.out.println( "Error2 en la Conexi�n con la BD "+ex.getMessage());
		    connection=null;
		}
		catch(Exception ex)
		{
			System.out.println( "Error3 en la Conexi�n con la BD "+ex.getMessage());
		    connection=null;
		}
		finally
		{
		    return connection;
		}
	}
		 
	/**
	 * Cierra la conexi�n a la base de datos
	 */
	public void cerrarConexion()
	{
		try
		{
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}


