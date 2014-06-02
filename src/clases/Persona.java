package clases;

/**
 * 
 * @author Nayelli Valeria PC - recluIT
 * @version 1.0 marzo2014
 * Clase Persona
 */

public class Persona {

	protected String nombre;
	protected String apePaterno;
	protected String apeMaterno;
	protected int idPersona;
	
	/**
	 * Constructor
	 */
	public Persona(){}
	
	/**
	 * Constructor
	 * @param id identificador de la persona
	 * @param nom nombre de la persona
	 * @param pat apellido paterno de la persona
	 * @param mat apellido materno de la persona
	 */
	public Persona(int id, String nom, String pat, String mat)
	{
		idPersona = id;
		nombre = nom;
		apePaterno = pat;
		apeMaterno = mat;
	}
	
	/**
	 * 
	 * @return  el nombre de la persona
	 */
	public String getNombre()
	{
		return nombre;
	}
	
	/**
	 * 
	 * @return el  apellido paterno de la persona
	 */
	public String getPaterno()
	{
		return apePaterno;
	}
	
	/**
	 * 
	 * @return el apellido materno de la persona
	 */
	public String getMaterno()
	{
		return apeMaterno;
	}
	
	/**
	 * Establece el nombre de la persona
	 * @param nom 
	 */
	public void setNombre( String nom)
	{
		nombre = nom;
	}
	
	/**
	 * Establece el apellido paterno de la persona
	 * @param pat
	 */
	public void setPaterno(String pat)
	{
		apePaterno = pat;
	}
	
	/**
	 * Establece el apellido materno de la persona
	 * @param mat
	 */
	public void setMaterno( String mat )
	{
		apeMaterno = mat;
	}
}
