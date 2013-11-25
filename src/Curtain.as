package {

  import flash.display.Sprite;
  import flash.events.*;
  import component.*;

  public class Curtain extends Sprite {

    private static const PLAY_BUTTON_COLOR: uint = 0x00BF8F;
    private static const PLAY_BUTTON_DIAMETER: uint = 100;

    public function Curtain(image: String, width: uint, height: uint) {
      var poster: Image = new Image(image, width, height);
      var background: Sprite = Helpers.circle(PLAY_BUTTON_DIAMETER, PLAY_BUTTON_COLOR);

      var playButton: Sprite = Helpers.withOpacity(0.85, Layout.middle(PLAY_BUTTON_DIAMETER, PLAY_BUTTON_DIAMETER, new Icon(Icon.PLAY, 56)));

      addEventListener(MouseEvent.ROLL_OVER, opacity(playButton, 1));
      addEventListener(MouseEvent.ROLL_OUT, opacity(playButton, playButton.alpha));

      addChild(poster);
      addChild(Layout.middle(width, height, playButton));

      Helpers.withPointer(this);
    }

    private static function opacity(object: Sprite, value: Number): Function {
      return function(): void {
        Helpers.withOpacity(value, object);
      };
    }

  }

}
