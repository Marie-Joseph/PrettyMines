public class PlayField : Gtk.Grid {

    // Properties
    public int size {get; construct set;}
    public int total_mines {get; set;}

    // Signals
    public signal void kill_everything ();
    public signal void remove_mine ();
    public signal void add_mine ();

    // Constuctors
    public PlayField (int size) {
        Object (size: size);
    }

    construct {
        generate_mines ();
    }

    // Utility functions

    /* The meat of the field, this is where all subwidgets are created and
    *   necessary events connected */
    void generate_mines () {

        total_mines = 0;

        for (int i = 0; i < this.size; i++) {

            for (int j = 0; j < this.size; j++) {

                // Create a new mine button and assign its position
                var new_mine = new MineButton ();
                new_mine.x_pos = i;
                new_mine.y_pos = j;

                // Randomly create mined buttons
                if (Random.int_range (0, this.size) == 0) {

                    new_mine.is_mine = true;
                    total_mines++;
                }

                new_mine.press_zeros.connect ( (button) => {

                    press_zeros (button);
                });

                // Removed mine (added flag) or added mine (removed flag)
                new_mine.mine_removed.connect ( (t) => {

                    remove_mine ();
                });
                new_mine.mine_added.connect ( (t) => {

                    add_mine ();
                });

                // Game over
                new_mine.kill_everything.connect ( (t) => {

                    press_all ();
                    kill_everything ();
                });

                attach (new_mine, i, j);
            }
        }

        set_neighbors ();
    }

    /* Sets the number of neighbors for each button */
    void set_neighbors () {


        for (int i = 0; i < this.size; i++) {

            for (int j = 0; j < this.size; j++) {

                var child = (MineButton) get_child_at (i, j);

                for (int k = -1; k < 2; k++) {

                    for (int l = -1; l < 2; l++) {

                        var check_child = (MineButton) get_child_at (i + k, j + l);
                        child.neighbors += check_child != null && check_child.is_mine ? 1 : 0;
                    }
                }
            }
        }
    }

    public void press_all () {
        for (int i = 0; i < this.size; i++) {

            for (int j = 0; j < this.size; j++) {

                var child = (MineButton) get_child_at (i, j);
                child.set_active (true);

                if (child.is_mine) {

                    child.set_image_mine();

                } else if (child.neighbors != 0) {

                    child.label = child.neighbors.to_string ();
                }
            }
        }
    }

    public void reset_field () {

        this.foreach ( (child) => {

            child.destroy ();
        });

        generate_mines ();
        show_all ();
    }

    public void press_zeros (MineButton button) {
        int x = button.x_pos;
        int y = button.y_pos;

        for (int k = -1; k < 2; k++) {

            for (int l = -1; l < 2; l++) {

                var neighbor = (MineButton?) get_child_at (x + k, y + l);

                if (!neighbor.active && neighbor != null) {
                    neighbor.set_active (true);
                    if (neighbor.neighbors == 0) {
                        press_zeros (neighbor);
                    } else {
                        neighbor.label = neighbor.neighbors.to_string ();
                    }
                }
            }
        }
    }
}
