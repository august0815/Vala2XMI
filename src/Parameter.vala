using GLib;
using Gee;

/**
 * Speichet die Parameter der Methode
 */
public class Parameter : Object
{
  /**
   * Speichert DATATYP für umbrello
   */
  public string typ {get;set;}
  /**
   * Speichert orginal string , nötig für 2-ten Durchlauf
   */
  public string typ_org {get;set;}
  /**
   * default in , inout ,out
   */
  public string kind {get;set;default = "in";}
  /**
   * IdentNR 
   */
  public string xmi_id {get;set;}
  /**
   * Name :)
   */
  public string name {get;set;}

  /**
   * Erzeuge
   */
  public Parameter(string name ,string typ,string typ_org){
		this.name=name;
		var id=Random.int_range(1,20000);
	    this.xmi_id = id.to_string();
		this.typ=typ;
		this.typ_org=typ_org;
		}


}

