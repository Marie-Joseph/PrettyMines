public class MineButton : Gtk.ToggleButton {

    // Signals
    public signal void press_zeros ();
    public signal void kill_everything ();
    public signal void mine_removed ();
    public signal void mine_added ();

    // Properties
    public int x_pos {get; set; default = 0;}
    public int y_pos {get; set; default = 0;}
    public int neighbors {get; set; default = 0;}
    public bool is_mine {get; set; default = false;}
    public bool is_flagged {get; set; default = false;}

    // Constructor
    public MineButton () {
        height_request = 28;
        width_request = 32;
    }

    public override bool button_press_event (Gdk.EventButton event) {
        if (active) {
            return true;
        }

        if (event.button == 1 && !is_flagged) {
            active = true;

            if (is_mine) {
                set_image_mine ();
                kill_everything ();
                return false;
            } else {
                if (neighbors == 0) {
                    press_zeros ();
                } else {
                    label = neighbors.to_string ();
                }
            }
        } else if (event.button == 3) {
            if (is_flagged) {
                image = null;
                is_flagged = false;
                mine_added ();
            } else {
                set_image_flag ();
                is_flagged = true;
                mine_removed ();
            }
        }
        return false;
    }

    public void set_image_mine () {
        // Setup mine image
        var mine = new Gtk.Image ();
        mine.gicon = new ThemedIcon ("image-red-eye");
        mine.pixel_size = 16;

        image = mine;
    }

    public void set_image_flag () {
        // Setup flag image
        var flag = new Gtk.Image ();
        flag.gicon = new ThemedIcon ("edit-flag");
        flag.pixel_size = 16;

        image = flag;
    }
}
