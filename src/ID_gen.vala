using Gtk;
using Gee;

public  class   ID_gen : Object  {
	public string ids="";

	public  ID_gen(){
		
			
		}
		public string getId_gen(){
		string idss="";
		idss=this.ids;
		var id=Random.int_range(1,20000);
		string idd=id.to_string();
		if (!(idd in ids)){
			ids +=idd+" , ";
			//print("IDS --->%s\n", ids);
			
			}
			return ids;}
	}
