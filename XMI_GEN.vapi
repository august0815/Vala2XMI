/* XMI_GEN.vapi generated by valac 0.18.1, do not modify. */

[CCode (cheader_filename = "src/main.h")]
public class Application : Granite.Application {
	public Application (string[] args);
}
[CCode (cheader_filename = "src/Window.h")]
public class XMIBuilder : Gtk.Window {
	public Gtk.Box vbox;
	public XMIBuilder (Granite.Application app);
}
[CCode (cheader_filename = "src/build_dir.h")]
public class Builder : GLib.Object {
	public int YANG;
	public Gee.HashMap<string,string> datatype;
	public MasterState master;
	public Builder ();
	public static void build_dir (MasterState master, string folder);
}
[CCode (cheader_filename = "src/MasterState.h")]
public class MasterState : GLib.Object {
	public Gee.ArrayList<CLASS> class_name;
	public Gee.HashMap<string,string> data;
	public DATATYPE datatype;
	public Gee.ArrayList<Filename> filenames;
	public string id_string;
	public Gee.ArrayList<Namespace> name_space;
	public MasterState ();
	public int addCLASS (string name, bool statik, string namespc, string id, string abstractt);
	public int addFilename (string name, string path);
	public int addNamespace (string name, string id);
	public Gee.ArrayList<CLASS> getCLASS ();
	public Gee.HashMap<string,string> getData ();
	public Gee.ArrayList<Filename> getFilenames ();
	public Gee.ArrayList<Namespace> getNamespace ();
	public string Modul_name { get; set; }
}
[CCode (cheader_filename = "src/CLASS.h")]
public class CLASS : GLib.Object {
	public string id_string;
	public CLASS (string name, string? id, bool statik, string namespc, string abstractt);
	public void addAttribute (string visibility, string name, string type, string typ_org, string id);
	public int addCLASSMethodParameter (string methodname, string name, string typ, string typ_org);
	public int addClassRetrunTyp (string methodname, string type, string typ_org);
	public void addMethod (string visibility, string name1, bool statik, bool constant, bool Abstract, string id);
	public Gee.ArrayList<Attribute> getAttribute ();
	public Gee.ArrayList<Method> getMethod ();
	public string Abstract { get; set; }
	public string class_string { get; set; }
	public string name { get; set; }
	public string namespc { get; set; }
	public bool statik { get; set; }
	public string visibility { get; set; }
	public string xmi_id { get; set; }
}
[CCode (cheader_filename = "src/Namespace.h")]
public class Namespace : GLib.Object {
	public Namespace (string name, string id);
	public int addCLASS (string name);
	public Gee.ArrayList<string> getList ();
	public string id_string { get; set; }
	public string name { get; set; }
}
[CCode (cheader_filename = "src/load_file.h")]
public class Loader : GLib.Object {
	public DATATYPE d;
	public GLib.File file;
	public string id_string;
	public MasterState master;
	public string name;
	public Loader (string path, string file_name);
	public string find_type (string? sort);
	public string getID ();
	public int identline (string line);
	public void parse (MasterState master);
	public string setclass (string line, string namespc);
	public void setmethod (string classname, string line);
	public string path { get; set construct; }
}
[CCode (cheader_filename = "src/Attribute.h")]
public class Attribute : GLib.Object {
	public Attribute (string visibility, string name, string? xmi_id, string typ, string typ_org);
	public string name { get; set; }
	public bool statik { get; set; }
	public string typ { get; set; }
	public string typ_org { get; set; }
	public string visibility { get; set; }
	public string xmi_id { get; set; }
}
[CCode (cheader_filename = "src/Datatype.h")]
public class DATATYPE : GLib.Object {
	public Gee.HashMap<string,string> data;
	public string id_string;
	public DATATYPE ();
	public Gee.HashMap<string,string> getData ();
}
[CCode (cheader_filename = "src/Method.h")]
public class Method : GLib.Object {
	public Method (string visibility, string name, string? xmi_id, bool statik, bool constant, bool Abstract);
	public void addParameter (string name, string typ, string typ_org);
	public void addRetrunTyp (string typ, string typ_org);
	public Gee.ArrayList<Parameter> getParameter ();
	public bool Abstract { get; set; }
	public bool constant { get; set; }
	public string kind { get; set; }
	public string name { get; set; }
	public string return_id { get; set; }
	public string return_typ { get; set; }
	public bool statik { get; set; }
	public string typ_org { get; set; }
	public string visibility { get; set; }
	public string xmi_id { get; set; }
}
[CCode (cheader_filename = "src/Parameter.h")]
public class Parameter : GLib.Object {
	public Parameter (string name, string typ, string typ_org);
	public string kind { get; set; }
	public string name { get; set; }
	public string typ { get; set; }
	public string typ_org { get; set; }
	public string xmi_id { get; set; }
}
[CCode (cheader_filename = "src/FileName.h")]
public class Filename : GLib.Object {
	public Filename (string name, string path);
	public string name { get; set; }
	public string path { get; set; }
}
[CCode (cheader_filename = "src/load_file_private.h")]
public class PrivateLoader : GLib.Object {
	public string content;
	public DATATYPE d;
	public GLib.File file;
	public string id_string;
	public MasterState master;
	public string name;
	public PrivateLoader (string path, string file_name);
	public string find_type (string? sort);
	public string getID ();
	public int identline (string line);
	public void parse (MasterState master);
	public string setclass (string line);
	public void setmethod (string classname, string? line);
	public string path { get; set construct; }
}
[CCode (cheader_filename = "src/Finish.h")]
public class Finish : GLib.Object {
	public Finish ();
	public string find_type (string sort, MasterState master);
	public MasterState tree (MasterState master);
}