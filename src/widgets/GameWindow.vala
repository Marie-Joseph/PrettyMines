public class GameWindow : Gtk.ApplicationWindow {

    // Signal
    public signal void reset_field ();

    // Properties
    public int size {get; set; default = 24;}

    public GameWindow (Gtk.Application application) {

        this.application = application;

        this.destroy.connect (Gtk.main_quit);

        add_events(Gdk.EventMask.BUTTON_PRESS_MASK);

        var playfield = new PlayField (this.size);
        var header = new Header (playfield.total_mines);

        /* Signal catches */
        // Catch gameover signal
        playfield.kill_everything.connect ( (t) => {
            header.lost = true;
        });

        // Add/remove mine counters
        playfield.remove_mine.connect ( (t) => {
            header.mines_left--;

            if (header.mines_left == 0) {
                for (int i = 0; i < size; i++) {
                    for (int j = 0; j < size; j++) {
                        var child = (MineButton) playfield.get_child_at (i, j);
                        if (child.is_mine && !child.is_flagged) {
                            header.mines_left++;
                        }
                    }
                }

                if (header.mines_left != 0) {
                    header.mines_left = 0;
                } else {
                    header.won = true;
                    playfield.press_all ();
                }
            }
        });

        playfield.add_mine.connect ( (t) => {
            header.mines_left++;
        });

        // Reset the field after hitting the smiley
        header.reset_field.connect ( (t) => {
            playfield.reset_field ();
            header.mines_left = playfield.total_mines;
        });

        header.size_changed.connect ( (t) => {
            this.size = header.size;
            playfield.size = this.size;
            playfield.reset_field ();
        });

        this.set_titlebar (header);
        this.add (playfield);
    }
}
