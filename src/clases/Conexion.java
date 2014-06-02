package clases;

/**
 * 
 * @author Nayelli Valeria PC - recluIT
 * @version 1.0 marzo2014
 * Esta clase describe la conexión de la aplicación a la base de datos.
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
	 * Constructor que inicializa los parémetros
	 * @param URL es la url de la base de datos
	 * @param user es el usuario de la sesión mysql
	 * @param pass es la contraseña de la sesiòn mysql
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
	 * Método que ejecuta la conexión
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
		    System.out.println( "Error1 en la Conexión con la BD "+ex.getMessage());
		    connection=null;
		}
		catch(SQLException ex)
		{
			System.out.println( "Error2 en la Conexión con la BD "+ex.getMessage());
		    connection=null;
		}
		catch(Exception ex)
		{
			System.out.println( "Error3 en la Conexión con la BD "+ex.getMessage());
		    connection=null;
		}
		finally
		{
		    return connection;
		}
	}
		 
	/**
	 * Cierra la conexión a la base de datos
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


