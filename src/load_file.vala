using GLib;
using Gee;

public class  Loader:  Object {
	
	public string path { get; construct set; }
	public string name ;
	public string id_string;
	public MasterState master;
	public File file;
	public Loader (string path, string file_name) {
	string filename=path+file_name;
    this.path=path;
	file = File.new_for_path (filename);
	}
	public DATATYPE d=new DATATYPE();
	
	public void /*MasterState*/ parse(MasterState master) {
		
		this.master=master;

	try {  
      // Open file for reading and wrap returned FileInputStream into a
      // DataInputStream, so we can read line by line
      var in_stream = new DataInputStream (file.read (null));
     string line;
     int deep=0;
     string namespc="";
      // Read lines until end of file (null) is reached
      while ((line = in_stream.read_line (null, null)) != null) {
			  if (!(line=="")){
			        int what=identline(line);
					switch (what) {
						
						case 1:
							{ 
							string[] filesname = line.split ("\"");
							master.addFilename(filesname[1],path);
							}
						break;	
						case 2:
							{
							deep ++;
							
								print ("Deep :"+deep.to_string()+" "+namespc+"\n");
							string classname =setclass(line,namespc);
							var loop=true;
							while (loop){
							line = in_stream.read_line (null, null);
							if  ("}"in line) {
								if (deep<1){namespc="";}
								print ("Deep :"+deep.to_string()+" "+namespc+"\n");
								loop=false;deep --;
								break;}
							setmethod(classname,line);
									
								}
						    }
						break;	
						case 3:
							{ deep ++;
							
							string[] nam=line.split(" ");
							namespc =nam[1];
							var id=getID();
							master.addNamespace(namespc,id);
							
								print ("Deep :"+deep.to_string()+" "+namespc+"\n");
							//var loop=true;
							//while (loop){
							//line = in_stream.read_line (null, null);
							//if ( ("}"in line) &&  (deep=1)){loop=false;deep --;namespace="";break;}
							
							}
						break;	
						case 4:
							{ 						
								deep --;
								if (deep<1){namespc="";}
								if (deep<0) {deep=0;}
							
								print ("Deep :"+deep.to_string()+" "+namespc+"\n");
							}
						break;
						case 5:
							{
							deep ++;
							
							print ("Deep :"+deep.to_string()+" "+namespc+"\n");
							string classname =setclass(line,namespc);
							var loop=true;
							while (loop){
							line = in_stream.read_line (null, null);
							if  ("}"in line) {
								if (deep<1){namespc="";}
								print ("Deep :"+deep.to_string()+" "+namespc+"\n");
								loop=false;deep --;
								break;}
							setmethod(classname,line);
									
								}
						    }
						break;	

						default:
						stdout.printf("unknown :%s\n",line);
						break;
						}				
				
        }
	}
	

}
      catch (Error e) {
      stderr.printf ("%s\n", e.message);
      //return 1;
		}
			}	
	/**
	* Was für win typ ist Eingabe
	*/
	public int identline (string line){
		var ret=0;
		if  ("cheader_filename" in line) {ret=1;}
		if  ("public class" in line) {ret=2;}
		if  ("public abstract" in line) {ret=5;}
		if  (("namespace" in line)&&("{" in line)) {ret=3;}
		if ("}" in line) {ret=4;}
		//if  ("cheader_filename" in line) {ret=1;}
		return ret;
		}
	/**
	* Fügt CLASS hinzu
	*/	
	public string setclass(string line,string namespc){
			string ret="";
			string[] lline=line.split(" ");
			var id=getID();
			switch (lline[1]) {
				case "static":
				{
					master.addCLASS(lline[3],true,namespc,id,"false");
				ret=lline[3];
				}
				break;
				case "abstract":
				{
					master.addCLASS(lline[3],false,namespc,id,"true");
				ret=lline[3];}
				break;
				
				default:
				master.addCLASS(lline[2],false,namespc,id,"false");
				ret=lline[2];
				break;
				}	
				
			print("RETURN "+ret+"\n");
			return ret;
		}
	/**
	* Fügt Methode , Attribute und ReturnTyp sowie Parameter der Methode hinzu 
	*/	
	public void setmethod(string classname,string line){
		//print ("LINIE >>>>>>%s<<<<<<<<<< ",line);
		//Zerlegen
		string[] lline=line.split(" ");
		//Es ist Methode
		   if (!("public "+classname in line)){
				if (("(" in line) && (")" in line )){
				
				int l=lline.length;
				//print ("länge %d \n",l);
				for (int i=0;i<l;i++){
					if("," in lline[i]){
						int ende=lline[i].length;
						lline[i]= lline[i].substring (0,ende-1);
						}
					if(")" in lline[i]){
						int ende=lline[i].length;
						lline[i]= lline[i].substring (0,ende-2);
						}
					if("(" in lline[i]){
						int ende=lline[i].length;
						lline[i]= lline[i].substring (1,ende-1);
						}		
						

					}	
					var clas=master.getCLASS();
					foreach(CLASS c in clas){ 
					if (c.name==classname){
						var id=getID();
						if ("static" in line){
							
							c.addMethod("public",lline[3],true,false,false,id);
							c.addClassRetrunTyp(lline[3],find_type(lline[2]),lline[2]);
							////print("PARAMETER ------->%s  %s\n",lline[3],lline[2]);
							if (l>4){
						for(int j=4;j<l;j=j+2){
							
							c.addCLASSMethodParameter(lline[3],lline[j+1],find_type(lline[j]),lline[j]);
							//print("PARAMETER ------->%s---->%s---\n",lline[j+1],lline[j]);
										}		
								}
						}
						else{	
							c.addMethod("public",lline[2],false,false,false,id);
							c.addClassRetrunTyp(lline[2],find_type(lline[1]),lline[1]);
							////print("PARAMETER ------->%s  %s\n",lline[2],lline[1]);
							if (l>4){
							for(int j=3;j<l;j=j+2){
							
							c.addCLASSMethodParameter(lline[2],lline[j+1],find_type(lline[j]),lline[j]);
							//print("PARAMETER ------->%s---->%s---\n",lline[j+1],lline[j]);
										}		
								}
						}
					
							
							
						
						
					}
				}
				}
				
				else {
					var id=getID();
					var clas=master.getCLASS();
					foreach(CLASS c in clas){ 
					if (c.name==classname){
						//und hinzufügen

						//Vorsicht "const"
						if ((lline[2]=="const")||(lline[2]=="abstract")){
							c.addAttribute(lline[0],lline[3],find_type(lline[2]),lline[2],id);						
											}
						else{
							if(";" in lline[2]){
						int ende=lline[2].length;
						lline[2]= lline[2].substring (0,ende-1);
						}
								c.addAttribute(lline[0],lline[2],find_type(lline[1]),lline[1],id);
						}
						}
						
					}
					
				}
				}
				else { /*print( " CLASSEN CONSTRUKT %s\n",line);*/}
			 
		}	
		
				
public string find_type (string? sort){
	string typ="";
		var datatype=master.getData();
		  	foreach (var entry in datatype.entries) {
				if (entry.key==sort){
					typ=entry.value;return typ;}
					else{
						typ="xxxxxx";}
			}
	return typ;}

	public string getID(){
		string idss="";
		string idd="";
		bool loop=true;
		while (loop){
		idss=this.id_string;
		var id=Random.int_range(1,20000);
		idd=id.to_string();
		if (!(idd in idss)){
			idss +=idd+" , ";
			this.id_string=idss;
			loop=false;break;
			}
		}
		return idd;
		}
}
