/*
Copyright (c) 2013 Mario Marcec <mario.marce42@googlmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal 
in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

using Granite;

public class Application : Granite.Application
	{
		XMIBuilder window;
	
		construct {

			program_name = "Vala2XMI";
			exec_name = "vala2xmi";
			
			app_copyright = "Mario Marcec <mario.marce42@googlmail.com> Projekt Developers";
			app_years = "2013";
			application_id = "apps.vala2xmi";
			app_icon = "vala2xmi";
			app_launcher = "vala2xmi.desktop";
			
			main_url = "https://github.com/august0815/Vala2XMI";
			bug_url = "";
			help_url = "";
			translate_url = "";
			
			about_authors = {
				"Mairo Marcec <mario.marce42@googlmail.com> ",
				null
			};
			
			about_comments = "Mario Marcec <mario.marce42@googlmail.com>";
			about_translators = "Translators";
			about_license_type = Gtk.License.GPL_3_0;
		}
		
		public Application(string[] args)
		{
			window = new XMIBuilder(this);
			window.show();
		}
	}
	

	
int main (string[] args) {
		Gtk.init (ref args);
		var valatoxmi= new Application(args);
		Gtk.main();
		return valatoxmi.run (args);;
	}

