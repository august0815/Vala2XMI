using GLib;

using Gee;


public class Namespace : Object
{
	public  string name {get;set;}
	public  string id_string{get;set;}
	
	private ArrayList<string> class_name = new ArrayList<string>();
	
	
  public Namespace (string name,string id)
  {  this.name=name;
	 this.id_string=id;
	 print("NAMESPACE"+name+"   "+id+"\n");
  
     }
     
          ~Namespace() {
     }
    public int  addCLASS(string name){
		foreach(string c in class_name){
			if (name==c){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			
			class_name.add(name); 	
			return 0;			
	}
	

	public ArrayList<string> getList(){
	 	return class_name;}
    
}

