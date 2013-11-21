package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class ShareButton extends Sprite {

    private static const DIAMETER: uint = 150;
    private static const SHARE_BUTTON_TEXT: TextFormat = new TextFormat("Arial", 32, 0xFFFFFF, true);
    private static const SHARE_BUTTON_ICON: TextFormat = new TextFormat("standalone-player-font", 80, 0xFFFFFF);

    public function ShareButton(name: String, char: String, url: String, bgColor: uint = 0x000000) {
      var textField: TextField = Helpers.text(name, SHARE_BUTTON_TEXT);
      var icon: TextField = Helpers.text(char, SHARE_BUTTON_ICON, true);
      var background: Sprite = Helpers.circle(DIAMETER, bgColor);

      background.addChild(Layout.fitHorizontally(DIAMETER, Layout.fitVertically(DIAMETER, icon)));

      addChild(Helpers.link(Layout.centerHorizontally(Layout.vertical(10, background, textField)), url));
    }

  }

}
