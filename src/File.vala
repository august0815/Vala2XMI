
using GLib;
using Gee;


/**
 * TODO.
 */
public class FileStreamReader : Object {
	public string filename {
		private set;
		get;
	}

	public string name {
		private set;
		get;
	}

	public string content {
		private set;
		get;
	}

	private MappedFile mapped_file;

	private string[] lines;
	private char* begin;
	private char* current;
	private char* end;

	private int line;
	private int column;

	private Map<string, string> attributes = new HashMap<string, string> (str_hash, str_equal);
	private bool empty_element;
	
	public FileStreamReader (string filename) {
		this.filename = filename;

		try {
			mapped_file = new MappedFile (filename, false);
			begin = mapped_file.get_contents ();
			lines = ((string) begin).split ("\n");
			end = begin + mapped_file.get_length ();

			current = begin;

			line = 1;
			column = 1;
		} catch (FileError e) {
			error ("%s: error: Unable to map file: %s", filename, e.message);
		}
	}

	public void reset () {
		current = begin;
		column = 1;
		line = 1;
	}
}
