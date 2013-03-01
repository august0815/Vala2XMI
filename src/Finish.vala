using GLib;


public class  Finish:  Object {
	
	public  MasterState tree(MasterState master){
		  var classlist=master.getCLASS();
			foreach (CLASS c in classlist){
			var atr=c.getAttribute();
			foreach(Attribute a in atr){
					if (a.typ=="xxxxxx"){
							a.typ=find_type(a.typ_org,master);
								}
							}
			var mth=c.getMethod();
		  	foreach(Method m in mth){	
					if (m.return_typ=="xxxxxx"){
						m.return_typ=find_type(m.typ_org,master);
						
						}
			var prmt=m.getParameter();
			foreach(Parameter p in prmt){
				if (p.typ=="xxxxxx"){
							p.typ=find_type(p.typ_org,master);} 
							}
						}
				}
		//alle *.tmp löschen
		return master;
		}
	public string find_type (string sort,MasterState master){
	string typ="";
	var clas=master.getCLASS();
		if ("Gee.ArrayList" in sort) {
			string[] ssort=sort.split_set(".<>");
			//print("%s    %s\n",ssort[1],ssort[2]);
			foreach(CLASS c in clas){ 
				if (ssort[2] in c.name){
					c.name=ssort[1]+" "+ssort[2];typ=c.xmi_id;return typ;}
				
		}
	}
/*	if ("Gee.HashMap" in sort) {
		string[] msort=sort.split(" ");
		 int l=msort.length;{
		 for (int i=0;i<l ;i ++)
			print("%s    %d \n",msort[i],i);
		}
			foreach(CLASS c in clas){ 
				if (msort[2] in c.name){
					c.name="HashMap" +" "+msort[2];typ=c.xmi_id;return typ;}
				}
		}*/
	
		else {

		  	foreach(CLASS c in clas){ 
				if (c.name==sort){
					typ=c.xmi_id;return typ;}
					
				var atr=c.getAttribute();
				foreach(Attribute a in atr){
					if(a.name==sort){
						typ=a.xmi_id;return typ;
						}
						else {typ="xxxxxx";}
					}		
				}
		}
	return typ;
	}
}
