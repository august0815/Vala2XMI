using Gtk;
using Gee;

public class XMIBuilder : Gtk.Window {

	public Gtk.Box vbox;	
	/**
	 * Creates a  window.
	 */
    private TextView text_view;
	/**
	 * Use to switch welcomscreen
	 */
	private bool welcom=true;
	//-------------------------------
    private MasterState master;
    
    private string text="";
    
		Granite.Widgets.Welcome welcome;
		
		// Toolbar elements
		Gtk.Toolbar toolbar = new Gtk.Toolbar();
		Gtk.Menu menu;
		Granite.Widgets.AppMenu appMenu;
		
    public XMIBuilder ( Granite.Application app) {
		
		master = new MasterState();
        set_default_size (800, 600);
			menu = new Gtk.Menu();
			welcome = new Granite.Widgets.Welcome("Transfer Vala to Umbrello XMI - Files\n  Start: select an *.vapi File .", "Open ...");
			
			// Menu
			menu.show_all();
			// AppMenu

			appMenu = app.create_appmenu(menu);
			var appMenu_item = new Gtk.ToolItem();
			appMenu_item.add(appMenu);

			// Menu item connections
			
				
			// Toolbar
			toolbar.get_style_context().add_class ("primary-toolbar");
			ToolButton menue_open =new ToolButton(new Image.from_stock(Stock.OPEN,IconSize.BUTTON),"");
			toolbar.insert(appMenu_item, -1);
			toolbar.insert(menue_open, -1);
			// Text
		        this.text_view = new TextView ();
			this.text_view.editable = false;
			this.text_view.cursor_visible = false;

			// Basic UI
			vbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			add (vbox);
			vbox.pack_start (toolbar, false, false);
			vbox.pack_start (welcome, true, true);
			vbox.show_all();
			toolbar.show_all();

			welcome.append(Gtk.Stock.OPEN, "Open ", "Open ....");
			welcome.set_sensitive(true); 
			welcome.show_all();
			// Connections
			welcome.activated.connect(on_welcome_activated);
			menue_open.clicked.connect (on_opendir_clicked);
			destroy.connect(close);

    }
   	private void on_welcome_activated(int index) {
			if (index == 0)
			{ on_opendir_clicked(); }
		}	
    private void on_opendir_clicked () {
		var file_chooser = new FileChooserDialog ("Vala to XMI", this,
                                      FileChooserAction.OPEN,
                                      Stock.CANCEL, ResponseType.CANCEL,
                                      Stock.OPEN, ResponseType.ACCEPT);
        if (file_chooser.run () == ResponseType.ACCEPT) {
            open_file (file_chooser.get_filename ());
        }
        file_chooser.destroy ();
    }
  

    private void open_file (string file) {
	string folder="";
	string[] path=file.split("/");
	int l=path.length;
	for (int i=0; i<(l-1); i++) {folder += path[i]+"/";}
	file=path[l-1];
	master = null;
	master= new MasterState ();
	//stdout.printf("Folder %s - File%s",folder,file);
    Loader load = new Loader(folder,file);
	load.parse(master);
	var fn=master.getFilenames();
	foreach (Filename f in fn){
	PrivateLoader lload = new PrivateLoader(f.path,f.name);
	lload.parse(master);}
    Finish finish=new Finish();
   
    master=finish.tree(master);
   
	 Builder.build_dir( master ,folder);	
     //Control.build( master ,folder);
      text="ALLES FERTIG " ;
          
     this.text_view.buffer.text =  text;
    }
    
	private void close() {
			hide();
			Gtk.main_quit();
		}	
  }
