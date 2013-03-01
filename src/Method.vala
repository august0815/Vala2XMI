using GLib;
using Gee;

/**
 * Methode der Klasse
 */
public class Method : Object
{
   /**
   * Liste der Übergabe-Parameter
   */
  private ArrayList<Parameter> parameter = new ArrayList<Parameter>();

  /**
   * Rückgabe Typ in DATATYP format
   */
  public string return_typ {get;set;}
   /**
   * Speichert orginal string , nötig für 2-ten Durchlauf
   */
  public string typ_org {get;set;}
   /**
   * Return IdentNR 
   */
  public string return_id {get;set;}
   /**
   * IdentNR 
   */
  public string xmi_id {get;set;}
  
  /**
   * Name
   */
  public string name {get;set;}
   /**
   * TODO: Add documentation here.
   * kann folgebde Zustände annehmen:
   * public,privat,protectet,implementation
   */
  public string visibility {get;set;}
   /**
   * Ist eigentlich static
   */
  public bool statik {get;set;}
  /**
   * wird zu : isQuery="true"
   */
  public bool constant {get;set;} 
  /**
   * wird zu: isAbstract="true"
   */public bool Abstract {get;set;} 
     /**
   * default in , inout ,out
   */
  public string kind {get;set;default = "return";}
  /**
   * TODO: Add documentation here.
   */
  public Method(string visibility,string name,string?  xmi_id,bool statik,bool constant,bool Abstract){
		this.name=name;
		this.xmi_id=xmi_id;
		this.visibility=visibility;
		this.statik=statik;
		this.constant=constant;
		this.Abstract=Abstract;
		}
  public void addRetrunTyp( string typ,string typ_org){
	  this.return_typ=typ;
	  this.typ_org=typ_org;
	  var id=Random.int_range(1,20000);
	  return_id = id.to_string();
  }
  public void addParameter(string name,string typ,string typ_org){
	  var newpa=new Parameter(name,typ,typ_org);
			parameter.add(newpa); 
		}
 public ArrayList<Parameter> getParameter(){
  return parameter;}

}

