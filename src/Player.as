package {

  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import flash.events.*;
  import flash.text.TextFormat;
  import flash.text.TextField;

  [SWF(backgroundColor="0xFFFFFF")]
  public class Player extends Sprite {

    [Embed(
      source = "../res/standalone-player-font.ttf",
      fontFamily="standalone-player-font",
      mimeType="application/x-font",
      advancedAntiAliasing="true",
      unicodeRange="U+E600-U+E607"
    )]
    private static var StandalonePlayerFont: Class;

    private static const PLAYER_SIZE: uint = 480;

    private static const AUDIO_FORMAT: TextFormat = new TextFormat("standalone-player-font", 32, 0xFFFFFF);

    public function Player() {
      try {
        init();
      } catch(e: Error) {
        Logger.error(e);
      }
    }

    private function init(): void {
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;

      Security.allowDomain("*");
      Security.allowInsecureDomain("*");

      var video: Video = new Video(
        loaderInfo.parameters.video,
        PLAYER_SIZE, PLAYER_SIZE,
        false, // autoplay
        true, // loop
        true // muted
      );

      var curtain: Sprite = new Curtain(loaderInfo.parameters.poster, PLAYER_SIZE, PLAYER_SIZE);
      curtain.addEventListener(MouseEvent.CLICK, function(): void {
        curtain.visible = false;
        video.play();
      });

      var audio: Sprite = Helpers.withOpacity(0.85, Helpers.sprite(Helpers.text(Icon.MUTE, AUDIO_FORMAT, true, "audio")));
      Helpers.withPointer(audio).addEventListener(MouseEvent.CLICK, function(e: MouseEvent): void {
        var textField: TextField = e.currentTarget.getChildByName("audio") as TextField;
        if (video.isMuted()) {
          textField.text = Icon.UNMUTE;
          video.unmute();
        } else {
          textField.text = Icon.MUTE;
          video.mute();
        }
      });

      var playPause: Sprite = Helpers.fill(PLAYER_SIZE, PLAYER_SIZE, 0x000000, 0);
      playPause.addEventListener(MouseEvent.CLICK, function(): void {
        video.isPaused() ? video.play() : video.pause();
      });

      var share: Share = new Share(
        loaderInfo.parameters.url,
        PLAYER_SIZE, PLAYER_SIZE
      );

      var details: Details = new Details(
        loaderInfo.parameters.name || "Ian Padgham",
        loaderInfo.parameters.avatar || "https://v.cdn.vine.co/v/avatars/637F68B3-FE31-424F-BC88-E8AA4BF293CE-6199-0000041FF76BBB5A.jpg?versionId=1OKBqNZJwbvX1bxqI3sh22C4gpjsIUX4",
        loaderInfo.parameters.text || "Look at these horses run free. It makes me so very #happy",
        loaderInfo.parameters.date || 1385018455000,
        loaderInfo.parameters.location || "Edinburgh",
        PLAYER_SIZE
      );

      share.visible = false;
      details.addEventListener(MouseEvent.CLICK, function(e: Event): void {
        if (e.target.name == "shareLink") {
          share.visible = !share.visible;
        }
      });

      var player: Sprite = new Sprite();
      player.addChild(video);
      player.addChild(playPause);
      player.addChild(Layout.absolute(15, 15, audio));
      player.addChild(curtain);
      player.addChild(share);

      addChild(scaleForStage(Layout.vertical(0, player, details)));
    }

    private function scaleForStage(layout: Sprite): Sprite {
      if (stage.stageWidth < stage.stageHeight) {
        layout.scaleX = layout.scaleY = stage.stageWidth / layout.width;
        return layout;
      } else {
        layout.scaleX = layout.scaleY = stage.stageHeight / layout.height;
        return Layout.fitHorizontally(stage.stageWidth, layout);
      }
    }

  }
}
