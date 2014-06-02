package clases;

/**
 * Clase Candidato
 * @author Nayelli Valeria PC - recluIT
 * @version 1.0 marzo2014
 * 
 */
public class Candidato extends Persona{

	private String curp;
	private String rfc;
	private String numero;
	private String email;
	private String palabrasclave;
	private String tecnologia;
	public int idCandidato;
	private int idReclutador;
	private String nombreReclutador;
	private String fechaRegistro;
	
	/**
	 * Constructor
	 */
	public Candidato(){}
	
	/**
	 * Constructor
	 * @param cu CURP del candidato
	 * @param rf RFC del candidato
	 * @param nu número telefónico del candidato
	 * @param em e-mail del candidato
	 * @param pa apellido paterno del candidato
	 * @param te tecnologías que usa el candidato
	 * @param idRe identificador del reclutador que lo registra
	 * @param nomRe nombre del reclutador que lo registra
	 * @param fe fecha de registro
	 */
	public Candidato( String cu, String rf, String nu, String em, String pa, String te,int idRe, String nomRe, String fe)
	{
		curp=cu;
		rfc=rf;
		numero=nu;
		email=em;
		palabrasclave=pa;
		tecnologia=te;
		fechaRegistro = fe;
	}
	
	/**
	 * Constructor
	 * @param no nombre del candidato
	 * @param pa apellido paterno del candidato
	 * @param ma apellido materno del candidato
	 * @param cu CURP del candidato
	 * @param rf RFC del candidato
	 * @param nu número telefónico del candidato
	 * @param em e-mail del candidato
	 * @param pal palabras clave que identifican al candidato
	 * @param te tecnologías que usa el candidato
	 * @param idRe identificador del reclutador que lo registra
	 * @param nomRe nombre del reclutador que registra
	 * @param fe fecha de registro
	 */
	public Candidato( String no, String pa, String ma, String cu, String rf, String nu, String em, String pal, String te,int idRe, String nomRe, String fe)
	{
		this.nombre = no;
		this.apeMaterno=ma;
		this.apePaterno=pa;
		curp=cu;
		rfc=rf;
		numero=nu;
		email=em;
		palabrasclave=pal;
		tecnologia=te;
		idReclutador=idRe;
		nombreReclutador=nomRe;
		fechaRegistro = fe;
	}
	
	/**
	 * 
	 * @return CUPR del candidato
	 */
	public String getCurp()
	{
		return curp;
	}
	
	/**
	 * 
	 * @return RFC del candidato
	 */
	public String getRFC()
	{
		return rfc;
	}
	
	/**
	 * 
	 * @return número telefónico del candidato
	 */
	public String getNumero()
	{
		return numero;
	}
	
	/**
	 * 
	 * @return e-mail del candidato
	 */
	public String getEmail()
	{
		return email;
	}
	
	/**
	 * 
	 * @return palabras clave del candidato
	 */
	public String getPalabras()
	{
		return palabrasclave;
	}
	
	/**
	 * 
	 * @return tecnología que usa el candidato
	 */
	public String getTecnologia()
	{
		return tecnologia;
	}
	
	/**
	 * 
	 * @return identificador del reclutador del candidato
	 */
	public int getIdReclutador()
	{
		return idReclutador;
	}
	
	/**
	 * 
	 * @return el nombre del reclutador del candidato
	 */
	public String getNombreReclutador()
	{
		return nombreReclutador;
	}
	
	/**
	 * 
	 * @return la fecha de registro del candidato
	 */
	public String getFechaRegistro()
	{
		return fechaRegistro;
	}
	
	/**
	 * 
	 * @param cu CURP del candidato
	 */
	public void setCurp(String cu)
	{
		curp = cu;
	}
	
	/**
	 * 
	 * @param rf RFc del candidato
	 */
	public void setRFC(String rf)
	{
		rfc=rf;
	}
	
	/**
	 * 
	 * @param nu Número telefónico del candidato
	 */
	public void setNumero(String nu)
	{
		numero = nu;
	}
	
	/**
	 * 
	 * @param em E-mail del candidato
	 */
	public void setEmail(String em)
	{
		email=em;
	}
	
	/**
	 * 
	 * @param pa palabras clave del candidato
	 */
	public void setPalabras(String pa)
	{
		palabrasclave=pa;
	}
	
	/**
	 * 
	 * @param te tecnologìa que usa el candidato
	 */
	public void setTecnologia(String te)
	{
		tecnologia=te;
	}
	
	/**
	 * 
	 * @param id identificador del reclutador del candidato
	 */
	public void setIdReclutador(int id)
	{
		idReclutador=id;
	}
	
	/**
	 * 
	 * @param nom nombre del reclutador del candidato
	 */
	public void setNombreReclutador(String nom)
	{
		nombreReclutador=nom;
	}
	
	/**
	 * 
	 * @param fe fecha de registro del candidato
	 */
	public void setFechaRegistro(String fe)
	{
		fechaRegistro =  fe;
	}
	
}

