package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class Details extends Sprite {

    private static const USERNAME_TEXT: TextFormat = new TextFormat("Helvetica, Arial", 18, 0x00BF8F, true);
    private static const MESSAGE_TEXT: TextFormat = new TextFormat("Helvetica, Arial", 16, 0x434343, false);
    private static const DETAILS_TEXT: TextFormat = new TextFormat("Helvetica, Arial", 10, 0xACB0B2, false);

    public function Details(name: String, avatarUrl: String, text: String, date: Number, locationName: String, width: uint) {

      var avatar: Sprite = new Avatar(avatarUrl, 50);

      var username: TextField = Helpers.text(name, USERNAME_TEXT);
      var message: TextField = Helpers.text(text, MESSAGE_TEXT);

      var details: TextField = Helpers.text([
        date.toString(),
        locationName ? "at " + locationName : "",
        "•",
        "Share"
      ].join(" "), DETAILS_TEXT);

      addChild(Layout.horizontal(10, avatar, Layout.vertical(5, username, message, Layout.horizontal(0, details))));
    }

  }

}
