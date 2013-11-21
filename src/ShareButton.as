package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class ShareButton extends Sprite {

    private static const SHARE_BUTTON_TEXT: TextFormat = new TextFormat("Arial", 28, 0xFFFFFF, true);
    private static const SHARE_BUTTON_ICON: TextFormat = new TextFormat("standalone-player-font", 56, 0xFFFFFF);

    public function ShareButton(name: String, char: String, url: String, bgColor: uint = 0x000000) {
      var textField: TextField = Helpers.text(name, SHARE_BUTTON_TEXT);
      var icon: TextField = Helpers.text(char, SHARE_BUTTON_ICON, true);

      addChild(Helpers.link(Layout.centerHorizontally(Layout.vertical(10, icon, textField)), url));
    }

  }

}
