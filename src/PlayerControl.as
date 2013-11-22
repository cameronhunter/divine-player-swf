package {

  import flash.display.Sprite;
  import flash.text.TextFormat;
  import flash.events.*;
  import flash.geom.ColorTransform;

  public class PlayerControl extends Sprite {

    private static const FOREGROUND: uint = 0xFFFFFF;
    private static const BACKGROUND: uint = 0x00BF8F;

    public function PlayerControl(icon: String) {
      var textFormat: TextFormat = new TextFormat("standalone-player-font", 48, FOREGROUND);
      textFormat.leftMargin = 8; // FIXME: Probably shouldn't need to do this

      var button: Sprite = Helpers.sprite(Helpers.text(icon, textFormat, true));
      var background: Sprite = Helpers.circle(85, BACKGROUND);

      addChild(background);
      addChild(Layout.middle(85, 85, button));
    }

  }

}