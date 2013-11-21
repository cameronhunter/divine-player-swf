package {

  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import flash.events.*;

  [SWF(backgroundColor="0xFFFFFF")]
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

      var playerSize: uint = stage.stageWidth;

      var playerContainer: Sprite = new Sprite();

      var poster: Image = new Image(
        loaderInfo.parameters.poster,
        playerSize, playerSize
      );

      var video: Video = new Video(
        loaderInfo.parameters.video,
        playerSize, playerSize,
        loaderInfo.parameters.autoplay == "true",
        loaderInfo.parameters.loop == "true",
        loaderInfo.parameters.muted == "true"
      );

      var share: Share = new Share(
        loaderInfo.parameters.url || "http://cameronhunter.co.uk",
        playerSize, playerSize
      );

      var details: Details = new Details(
        loaderInfo.parameters.name || "Ian Padgham",
        loaderInfo.parameters.avatar || "https://v.cdn.vine.co/v/avatars/637F68B3-FE31-424F-BC88-E8AA4BF293CE-6199-0000041FF76BBB5A.jpg?versionId=1OKBqNZJwbvX1bxqI3sh22C4gpjsIUX4",
        loaderInfo.parameters.text || "Look at these horses run free. It makes me so very #happy",
        loaderInfo.parameters.date || 1385018455,
        loaderInfo.parameters.location || "Edinburgh",
        stage.stageWidth
      );

//      share.visible = false;
//      addEventListener(MouseEvent.ROLL_OVER, show(share, true));
//      addEventListener(MouseEvent.ROLL_OUT, show(share, false));

      playerContainer.addChild(poster);
      playerContainer.addChild(video);
      playerContainer.addChild(share);

      addChild(Layout.vertical(0, playerContainer, details));
    }

    private static function show(view: Sprite, value: Boolean): Function {
      return function(e: Event): void {
        view.visible = value;
      };
    }
  }
}
