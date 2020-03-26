public class GameMenu : Gtk.Menu {

    // Properties
    public int size {get; set; default = 24;}

    // Signals
    public signal void size_changed ();

    public GameMenu () {

        var x16 = new Gtk.MenuItem.with_label ("16x16");
        var x24 = new Gtk.MenuItem.with_label ("24x24 (default)");
        var x32 = new Gtk.MenuItem.with_label ("32x32");
        var x40 = new Gtk.MenuItem.with_label ("40x40");

        for (int i = 0; i < 4; i++) {

            Gtk.MenuItem? child = null;

            switch (i) {
                case (0):
                    child = x16;
                    break;
                case (1):
                    child = x24;
                    break;
                case(2):
                    child = x32;
                    break;
                case(3):
                    child = x40;
                    break;
            }

            child.activate.connect ( (t) => {
                int new_size = int.parse (child.label[0:2]);
                if (this.size != new_size) {
                    this.size = new_size;
                    size_changed ();
                }
            });
        }

        attach (x16, 0, 1, 0, 1);
        attach (x24, 0, 1, 1, 2);
        attach (x32, 0, 1, 2, 3);
        attach (x40, 0, 1, 3, 4);

        show_all ();
    }
}
