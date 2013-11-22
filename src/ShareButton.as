package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class ShareButton extends Sprite {

    private static const DIAMETER: uint = 100;
    private static const SHARE_BUTTON_TEXT: TextFormat = new TextFormat("Helvetica, Arial", 24, 0xFFFFFF);
    private static const SHARE_BUTTON_ICON: TextFormat = new TextFormat("standalone-player-font", 56, 0xFFFFFF);

    public function ShareButton(name: String, char: String, url: String, bgColor: uint = 0x000000) {
      var textField: TextField = Helpers.text(name, SHARE_BUTTON_TEXT);
      var icon: TextField = Helpers.text(char, SHARE_BUTTON_ICON, true);
      var background: Sprite = Helpers.circle(DIAMETER, bgColor);

      background.addChild(Layout.fitHorizontally(DIAMETER, Layout.fitVertically(DIAMETER, icon)));

      addChild(Helpers.link(Layout.centerHorizontally(Layout.vertical((textField.height / 2), background, textField)), url));
    }

  }

}
