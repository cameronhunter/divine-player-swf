package activity {

  import flash.display.Sprite;
  import flash.events.*;
  import component.*;
  import util.*;

  public class Curtain extends Sprite {

    private static const PLAY_BUTTON_COLOR: uint = 0x00BF8F;
    private static const PLAY_BUTTON_DIAMETER: uint = 100;

    public function Curtain(image: String, width: uint, height: uint) {
      var poster: Image = new Image(image, width, height);
      var background: Sprite = Helpers.circle(PLAY_BUTTON_DIAMETER, PLAY_BUTTON_COLOR);

      var playButton: Sprite = Helpers.withOpacity(0.85, new Sprite());
      playButton.addChild(background);
      playButton.addChild(Layout.middle(PLAY_BUTTON_DIAMETER, PLAY_BUTTON_DIAMETER, new Icon(Icon.PLAY, 48)));

      addEventListener(MouseEvent.ROLL_OVER, opacity(playButton, 1));
      addEventListener(MouseEvent.ROLL_OUT, opacity(playButton, playButton.alpha));

      var playButtonContainer: Sprite = Layout.middle(width, height, playButton);
      playButtonContainer.name = "playButton";

      addChild(poster);
      addChild(playButtonContainer);

      Helpers.withPointer(this);
    }

    private static function opacity(object: Sprite, value: Number): Function {
      return function(): void {
        Helpers.withOpacity(value, object);
      };
    }

  }

}
