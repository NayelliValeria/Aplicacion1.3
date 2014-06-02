package clases;

public class Tecnologia {

	private int id;
	private String nombre;
	private String descripcion;
	
	public Tecnologia(){}
	
	public Tecnologia(int i)
	{
		id = i;
	}
	
	public Tecnologia(int i, String n, String d)
	{
		id = i;
		nombre = n;
		descripcion = d;
	}
	
	public int getId()
	{return id;}
	
	public String getNombre()
	{return nombre;}
	
	public String getDescripcion()
	{return descripcion;}
	
	public void setId(int i)
	{id=i;}
	
	public void setNombre(String n)
	{nombre=n;}
	
	public void setDescripcion(String d)
	{descripcion=d;}
}
