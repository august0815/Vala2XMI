using GLib;
using Gee;

/**
 * TODO: Add documentation here.
 */
public class Filename : Object
{

  /**
   * TODO: Add documentation here.
   */
  public string name {get;set;}
  public string path {get;set;}

  public Filename(string name,string  path){
		string[] mname=name.split(".");
		this.name=mname[0]+".vala";
		this.path=path;
		}
	

}

