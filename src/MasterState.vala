using GLib;

using Gee;


public class MasterState : Object
{
	public  string Modul_name {get;set;}
	public HashMap<string, string>  data;
	public ArrayList<Filename> filenames= new ArrayList<Filename>();
	public ArrayList<Namespace>  name_space = new ArrayList<Namespace>();
	public ArrayList<CLASS>  class_name = new ArrayList<CLASS>();
	public DATATYPE datatype;

  /**
   * TODO: Add documentation here.
   */


 public string id_string; 
  public MasterState()
  {  Modul_name="NEW";
    datatype=new DATATYPE();
	
    id_string=" ";
     }
     
          ~MasterState() {
     }

		
        public int  addCLASS(string name ,bool statik,string namespc,string id,string abstractt){
		foreach(CLASS c in class_name){
			if (name==c.name){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			print(" Class " + name+" "+id+"\n");
		if (namespc==""){
			var newclass=new CLASS(name,id,statik,namespc,abstractt);
		class_name.add(newclass); 	
		}
		else {
				foreach(Namespace n in name_space){
				if (n.name==namespc)
				n.addCLASS(name);
				}
			var newclass=new CLASS(name,id,statik,namespc,abstractt);
			class_name.add(newclass); 	}

		
		return 0;				
	}

	public ArrayList<CLASS> getCLASS(){
	 	return class_name;}
	 	
	public int addFilename(string name,string path){
		foreach(Filename f in filenames){
			if (name==f.name){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			var newfilenames=new Filename(name,path);
			filenames.add(newfilenames); 	
			return 0;			
	}
	public ArrayList<Filename> getFilenames(){
	 	return filenames;}
	 	
    public int  addNamespace(string name,string id){
		foreach(Namespace n in name_space){
			if (name==n.name){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			var newnames=new Namespace(name,id);
			name_space.add(newnames); 	
			return 0;			
	}
	public ArrayList<Namespace> getNamespace(){
	 	return name_space;}
	public HashMap<string, string> getData(){
		 data=datatype.getData();
		   return data;
		   }
	
}

