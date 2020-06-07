public class Header : Gtk.HeaderBar {

    // Properties
    public bool won {get; set; default = false;}
    public bool lost {get; set; default = false;}
    public int mines_left {get; set; default = 0;}
    public int size {get; set; default = 24;}

    // Signals
    public signal void reset_field ();
    public signal void size_changed ();

    // Constructor
    public Header (int total_mines) {
        title = "Pretty Mines";
        mines_left = total_mines;

        show_close_button = true;
        has_subtitle = false;

        // The reset button and its images
        var neutral_smiley = new Gtk.Image ();
        neutral_smiley.gicon = new ThemedIcon ("face-smile-symbolic");
        neutral_smiley.pixel_size = 20;

        var victory_smiley = new Gtk.Image ();
        victory_smiley.gicon = new ThemedIcon ("face-cool-symbolic");
        victory_smiley.pixel_size = 20;

        var loss_smiley = new Gtk.Image ();
        loss_smiley.gicon = new ThemedIcon ("face-sad-symbolic");
        loss_smiley.pixel_size = 20;

        var reset_button = new Gtk.Button ();
        reset_button.set_image (neutral_smiley);
        reset_button.clicked.connect ( (t) => {
            reset_field ();
            lost = false;
            reset_button.set_image (neutral_smiley);
        });

        // The mine tracker/scorekeeper
        var mine_display = new Gtk.Label (@"Mines left: $mines_left");

        // The settings button
        var game_menu = new GameMenu ();
        var settings_button = new Gtk.MenuButton ();
        settings_button.direction = Gtk.ArrowType.NONE;
        settings_button.valign = Gtk.Align.CENTER;
        settings_button.popup = game_menu;

        game_menu.size_changed.connect ( (t) => {
            this.size = game_menu.size;
            size_changed ();
        });

        // Packing order
        pack_start (reset_button);
        pack_start (mine_display);
        pack_end (settings_button);

        notify["lost"].connect ( (t) => {
            reset_button.set_image (loss_smiley);
        });
        notify["won"].connect ( (t) => {
            reset_button.set_image (victory_smiley);
        });
        notify["mines-left"].connect ( (t) => {
            mine_display.set_text (@"Mines left: $mines_left");
        });
    }
}
