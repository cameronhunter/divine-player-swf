package {

  import flash.display.Sprite;
  import flash.events.*;

  public class Curtain extends Sprite {

    private static const PLAY_BUTTON_OPACITY: Number = 0.85;

    public function Curtain(image: String, width: uint, height: uint) {
      var poster: Image = new Image(image, width, height);
      var playButton: Sprite = Helpers.withOpacity(PLAY_BUTTON_OPACITY, new PlayerControl(Icon.PLAY));

      addEventListener(MouseEvent.ROLL_OVER, opacity(playButton, 1));
      addEventListener(MouseEvent.ROLL_OUT, opacity(playButton, PLAY_BUTTON_OPACITY));

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
