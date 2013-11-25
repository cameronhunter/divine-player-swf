package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.geom.ColorTransform;
  import flash.events.*;

  public class ShareButton extends Sprite {

    private static const DIAMETER: uint = 100;
    private static const SHARE_BUTTON_TEXT: TextFormat = new TextFormat("Helvetica, Arial", 24, 0xFFFFFF);

    public function ShareButton(name: String, char: String, url: String, bgColor: uint = 0x000000) {
      var textField: Sprite = Helpers.sprite(Helpers.text(name, SHARE_BUTTON_TEXT));
      var icon: Sprite = new Icon(char, 56, 0xFFFFFF);
      var background: Sprite = Helpers.circle(DIAMETER, bgColor);

      var normal: ColorTransform = background.transform.colorTransform;
      var bright: ColorTransform = Helpers.brightnessTransform(20);

      addEventListener(MouseEvent.ROLL_OVER, Helpers.transformColor(background, bright));
      addEventListener(MouseEvent.ROLL_OUT, Helpers.transformColor(background, normal));

      background.addChild(Layout.fitHorizontally(DIAMETER, Layout.fitVertically(DIAMETER, icon)));

      addChild(Helpers.link(Layout.centerHorizontally(Layout.vertical((textField.height / 2), background, textField)), url));
    }

  }

}
