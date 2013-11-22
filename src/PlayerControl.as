package {

  import flash.display.Sprite;
  import flash.text.TextFormat;
  import flash.events.*;
  import flash.geom.ColorTransform;

  public class PlayerControl extends Sprite {

    private static const WHITE: uint = 0xFFFFFF;
    private static const HOVER_COLOR: uint = 0x00BF8F;

    public function PlayerControl(icon: String) {
      var textFormat: TextFormat = new TextFormat("standalone-player-font", 48, WHITE);
      textFormat.leftMargin = icon == Icon.PLAY ? 8 : 0; // FIXME: Probably shouldn't need to do this

      var button: Sprite = Helpers.sprite(Helpers.text(icon, textFormat, true));
      var background: Sprite = Helpers.circle(85, HOVER_COLOR, 0.9);

      var onBlur: ColorTransform = background.transform.colorTransform;
      var onHover: ColorTransform = new ColorTransform();
      onHover.alphaOffset = 255;

      addEventListener(MouseEvent.ROLL_OVER, function(e: Event): void {
        background.transform.colorTransform = onHover;
      });

      addEventListener(MouseEvent.ROLL_OUT, function(e: Event): void {
        background.transform.colorTransform = onBlur;
      });

      addChild(background);
      addChild(Layout.middle(85, 85, button));

      Helpers.withPointer(this);
    }

  }

}