using GLib;
using Gee;

/**
 * TODO: Add documentation here.
 */
public class CLASS : Object
{

	 private ArrayList<Attribute> attribute = new ArrayList<Attribute>();
	 private ArrayList<Method> method = new ArrayList<Method>();
  /**
   * TODO: Add documentation here.
   */
  
  public string class_string{get;set;}

  public string xmi_id {get;set;}
 
    /**
   * TODO: Add documentation here.
   * kann folgebde Zustände annehmen:
   * public,privat,protectet,implementation
   */
  public string visibility {get;set;}
   /**
   * wird zu: isAbstract="true"
   */public string Abstract {get;set;} 
  /**
   * TODO: Add documentation here.
   */
   public string namespc{get;set;}
   public bool statik {get;set;}
  public string name {get;set;}
public string id_string;
  /**
   * TODO: Add documentation here.
   */
  public CLASS(string name,string? id,bool statik,string namespc,string abstractt){
		this.name=name;
		//this.id_string=" ";
		this.xmi_id= id;
		this.statik=statik;
		this.namespc=namespc;
		this.Abstract=abstractt;
		}
  public void addAttribute(string visibility,string name,string type,string typ_org,string id){
	  	 var newattr=new Attribute(visibility,name,id,type,typ_org);
		attribute.add(newattr);
		  
		}
  public ArrayList<Attribute> getAttribute(){
  return attribute;}
  public int addClassRetrunTyp(string methodname,string type,string typ_org){
	  //stdout.printf("Method %s  TYPE %s\n ",methodname,type);
	  foreach(Method m in method){
			//stdout.printf("METHOD %sTYPE %s\n ",m.name,type);
			if (methodname==m.name){ 
				m.addRetrunTyp(type,typ_org);
			return 0;}
			}
	     return 0;
	     }
 public int addCLASSMethodParameter(string methodname,string name ,string typ,string typ_org){
		foreach(Method m in method){
			if (methodname==m.name){
				m.addParameter(name,typ,typ_org);
			return 0;}
			}	
		return 0;}

 public void addMethod(string visibility,string name1,bool statik,bool constant,bool Abstract,string id){
	 		var newmet=new Method(visibility,name1,id,statik,constant,Abstract);
	 		method.add(newmet);
			}
  public ArrayList<Method> getMethod(){
  return method;}

}

