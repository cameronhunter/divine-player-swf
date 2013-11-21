package {

  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import flash.events.*;

  public class Player extends Sprite {

    [Embed(
      source = "../res/standalone-player-font.ttf",
      fontFamily="standalone-player-font",
      mimeType="application/x-font",
      advancedAntiAliasing="true",
      unicodeRange="U+E600-U+E601"
    )]
    private static var StandalonePlayerFont: Class;

    public function Player() {
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;

      Security.allowDomain("*");
      Security.allowInsecureDomain("*");

      var poster: Image = new Image(
        loaderInfo.parameters.poster,
        stage.stageWidth,
        stage.stageHeight
      );

      var video: Video = new Video(
        loaderInfo.parameters.video,
        stage.stageWidth,
        stage.stageHeight,
        loaderInfo.parameters.autoplay == "true",
        loaderInfo.parameters.loop == "true",
        loaderInfo.parameters.muted == "true"
      );

      var share: Share = new Share(
        loaderInfo.parameters.url || "http://cameronhunter.co.uk",
        stage.stageWidth,
        stage.stageHeight
      );

      share.visible = false;

      addEventListener(MouseEvent.ROLL_OVER, show(share, true));
      addEventListener(MouseEvent.ROLL_OUT, show(share, false));

      addChild(poster);
      addChild(video);
      addChild(share);
    }

    private static function show(view: Sprite, value: Boolean): Function {
      return function(e: Event): void {
        view.visible = value;
      };
    }
  }
}
