using GLib;
using Gee;

public class  PrivateLoader :  Object {
	
	public string path { get; construct set; }
	public string name ;
	public MasterState master;
	public File file;
	public string id_string;
	
	public string content ;
	public PrivateLoader (string path, string file_name) {
	string filename=path+file_name;
		 file = File.new_for_path (filename+".tmp");
		 this.path=path;
		 this.name=file_name;
	}
	public DATATYPE d=new DATATYPE();
	
	public void /*MasterState*/ parse(MasterState master) {
		string all="";
		string all_fertig="";
		this.master=master;
  try {
     
      FileUtils.get_contents (path+name,out content);
		// Kommentarzeilen entfernen
      for (weak string s = content; s.get_char ()!=0 ; s = s.next_char ()) {
      unichar c = s.get_char ();
          	if(c=='/') {
			  s = s.next_char (); 
			  c = s.get_char ();
			  if(c=='/') {
			  		all +="\n";
			  		while (!(c=='\n')){
				  	  s = s.next_char (); 
				  	  c = s.get_char ();
				  	}
			  	}	
			  if(c=='*') {
			  	while(true) {	
			  		s = s.next_char (); 
			  		c = s.get_char ();
			  		if(c=='*') {
				  		s = s.next_char (); 
				  		c = s.get_char ();
					  	if(c=='/') {
					  		break;
					    	}
				  	  }
			  	  }
			    }
		  	}
		  	else  { 
			  string help = c.to_string();
			  all +=help;
			 	}
			
	    }
	    //In einzelne Worte teilen
	    string[] fl=all.split("\n");
	    int lng=fl.length;
	    for (int j=0;j<lng;j ++){
	    string oline="";
		  	  string hhelp = fl[j];
		  	  //finde Schlüsselworte
		  	  if (("private" in hhelp )||("public" in hhelp)||("namespace" in hhelp)||("{" in hhelp)||("}" in hhelp)){
				  //entferne Leerzeichen
				  string[] hhhelp=hhelp.split_set(" :{");
				  int l=hhhelp.length;
				  for (int i=0;i<l;i ++){
					  if (hhhelp[i]!=""){oline +=hhhelp[i]+" ";}
					  }
				 ;
			if (oline!=""){
			all_fertig += oline+"\n";	  

		 }
				}
			}
	    all_fertig +="\n}\n";
	   	}
	      catch (Error e) {
        stderr.printf ("%s\n", e.message);
        //return 1;
    }
	
	//untersuche modifizierte Datei	
      string[] stream =all_fertig.split("\n");
      int lang=stream.length;

     string line;
      // Read lines until end of string[] is reached
        for  (int l=0;l<lang;l ++){
			line= stream[l];
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
							string classname =setclass(line);
							// Nur wenn wirklich CLASS !
							if (classname!=""){
							var loop=true;
							while (loop){
								l ++;
							line= stream[l];
							setmethod(classname,line);
							if ( ("}"in line) && (line.char_count()==1)){
								loop=false;break;}
									}
								}
							}
						break;	
						case 3:
							{ 
							var loop=true;
							while (loop){
								l ++;
							line= stream[l];
							if ( ("}"in line) &&  (line.char_count()==1)){loop=false;break;}
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
	
	public int identline (string line){
		var ret=0;
		//if  ("cheader_filename" in line) {ret=1;}
		if  (("public" in line)&&("class" in line))  {ret=2;}
		//if  (("namespace" in line)&&("{" in line)) {ret=3;}
		
		return ret;
		}
	/**
	 * Fügt CLASS hinzu und liefert den Name als Ergebniss 
	 * Stellt sicher dass kein falscher String übergeben wird 
	 */
	public string setclass(string line){
		string abstractt="false";
		    string[] lline=line.split(" ");
			int l=lline.length;
			for (int i=0;i<l;i ++){
			if (lline[i]=="public"){
				var id=getID();
			if(lline[2]=="static")
				{master.addCLASS(lline[3],true,"",id,abstractt);}
			else{
				master.addCLASS(lline[2],false,"",id,abstractt);}
			return lline[2];}
			}
			return "";
		}	
	public void setmethod(string classname,string? line){
		/**
		* TODO: Bessere erkennung Attribute Metode
		* private string test = new test(); wird falsch erkannt.
		*/
		if ("=" in line){
						string[] h=line.split("=");
						line=h[0];
						}
		string[] lline=line.split(" ");
		int l=lline.length;
		   if (( lline[0]=="private")){
				if (("(" in line) && (")" in line )){
					for (int i=0;i<l;i++){
					if("," in lline[i]){
						int ende=lline[i].length;
						lline[i]= lline[i].substring (0,ende-1);
						}
					if(")" in lline[i]){
						int ende=lline[i].length;
						lline[i]= lline[i].substring (0,ende-1);
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
							c.addMethod("private",lline[3],true,false,false,id);
							c.addClassRetrunTyp(lline[3],find_type(lline[2]),lline[2]);
							//print("PARAMETER ------->%s  %s\n",lline[3],lline[2]);
							if (l>3){
						for(int j=3;j<l;j=j+2){
							
							c.addCLASSMethodParameter(lline[3],lline[j+1],find_type(lline[j]),lline[j]);
							//print("PARAMETER ------->%s---->%s---\n",lline[j+1],lline[j]);
										}		
								}
						}
						else{	
							c.addMethod("private",lline[2],false,false,false,id);
							c.addClassRetrunTyp(lline[2],find_type(lline[1]),lline[1]);
							//print("PARAMETER ------->%s  %s\n",lline[2],lline[1]);
							if (l>3){
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
					//It is an Attribute
					var id=getID();
					//Suche Richtige Classe
					var clas=master.getCLASS();
					foreach(CLASS c in clas){ 
					if (c.name==classname){
							//print ("Classname %s MethodeNAME %s\n",c.name,classname);
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
			//print("METHODE  --->%s***\n", name1);
			this.id_string=idss;
			loop=false;break;
			}
		}
		return idd;
		}
}
