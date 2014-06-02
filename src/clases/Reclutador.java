package clases;

/**
 * 
 * @author Nayelli Valeria PC - recluIT
 * @version 1.0 marzo2014
 * Clase Reclutador
 */

public class Reclutador extends Persona{
	private String user;
	private String pass;
	public int idReclutador;
	private boolean admin;
	
	/**
	 * Constructor
	 */
	public Reclutador(){}
	
	/**
	 * Cosntructor
	 * @param us nombre de usuario del reclutador
	 * @param pa contraseña del reclutador
	 */
	public Reclutador(String us, String pa)
	{
		user=us;
		pass=pa;
	}
	
	/**
	 * Constructor
	 * @param no nombre del reclutador
	 * @param pa apellido paterno del reclutador
	 * @param ma apellido materno del reclutador
	 * @param us nombre de usuario del reclutador
	 * @param pas contraseña del reclutador
	 */
	public Reclutador( String no, String pa, String ma, String us, String pas)
	{
		nombre = no;
		apePaterno = pa;
		apeMaterno = ma;
		user = us;
		pass = pas;
	}
	
	/**
	 * 
	 * @param us nombre de usuario del reclutador
	 */
	public void setUser(String us)
	{
		user = us;
	}
	
	/**
	 * 
	 * @param pa contraseña del reclutador
	 */
	public void setPass(String pa)
	{
		pass = pa;
	}

	/**
	 * 
	 * @return el nombre de usuario del reclutador
	 */
	public String getUser()
	{
		return user;
	}
	
	/**
	 * 
	 * @return la contraseña del reclutador
	 */
	public String getPass()
	{
		return pass;
	}
	
	/**
	 * 
	 * @return true si es administrador, false de lo contrario
	 */
	public boolean getAdmin()
	{
		return admin;
	}
	
	/**
	 * 
	 * @param ad persmisos de administrador
	 */
	public void setAdmin(boolean ad)
	{
		admin =  ad;
	}
}
