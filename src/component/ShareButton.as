package component {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.geom.ColorTransform;
  import flash.events.*;
  import util.*;

  public class ShareButton extends Sprite {

    private static const DIAMETER: uint = 100;
    private static const SHARE_BUTTON_TEXT: TextFormat = new TextFormat("Helvetica, Arial", 24, 0xFFFFFF);

    public function ShareButton(name: String, char: String, bgColor: uint) {
      var textField: Sprite = Helpers.sprite(Helpers.text(name, SHARE_BUTTON_TEXT));
      var icon: Sprite = new Icon(char, 56, 0xFFFFFF);
      var background: Sprite = Helpers.circle(DIAMETER, bgColor);

      var normal: ColorTransform = background.transform.colorTransform;
      var bright: ColorTransform = Helpers.brightnessTransform(20);

      addEventListener(MouseEvent.ROLL_OVER, Helpers.transformColor(background, bright));
      addEventListener(MouseEvent.ROLL_OUT, Helpers.transformColor(background, normal));

      background.addChild(Layout.fitHorizontally(DIAMETER, Layout.fitVertically(DIAMETER, icon)));

      var button: Sprite = Helpers.withPointer(Layout.centerHorizontally(Layout.vertical((textField.height / 2), background, textField)))
      button.name = char;

      addChild(button);
    }

  }

}
