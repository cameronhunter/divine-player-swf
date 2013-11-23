package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class Details extends Sprite {

    private static const USERNAME_TEXT: TextFormat = new TextFormat(
      "Helvetica Neue, Arial",
      23,       // font-size
      0x00BF8F, // color
      true      // bold
    );

    private static const MESSAGE_TEXT: TextFormat = new TextFormat(
      "Helvetica Neue, Arial",
      23,       // font-size
      0x434343  // color
    );

    private static const DETAILS_TEXT: TextFormat = new TextFormat(
      "Helvetica Neue, Arial",
      13,       // font-size
      0xACB0B2  // color
    );

    public function Details(name: String, avatarUrl: String, text: String, date: Number, locationName: String, width: uint, height: uint) {
      var avatar: Sprite = new Avatar(avatarUrl, 70);

      var caption: TextField = Helpers.multiline(370, [
        {text: name, format: USERNAME_TEXT},
        {text: text, format: MESSAGE_TEXT}
      ]);

      var details: TextField = Helpers.text([
        new Date(date).toLocaleDateString(),
        locationName ? "at " + locationName : "",
        "•",
        "Share"
      ].join(" "), DETAILS_TEXT);

      var textPart: Sprite = Layout.vertical(5, caption, details);
      var layout: Sprite = Layout.horizontal(10, avatar, textPart);

      layout.x = 10;
      layout.y = 10;

      addChild(layout);
    }

  }

}
