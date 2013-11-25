package {

  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import flash.events.*;
  import flash.text.TextFormat;
  import flash.text.TextField;
  import component.*;

  [SWF(backgroundColor="0xFFFFFF")]
  public class Player extends Sprite {

    [Embed(
      source = "../res/vine-icons.ttf",
      fontFamily = "vine-icons",
      mimeType = "application/x-font",
      advancedAntiAliasing = "true",
      unicodeRange = "U+E600-U+E607"
    )]
    private static var VineIconFont: Class;

    private static const PLAYER_SIZE: uint = 480;

    public function Player() {
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

      var audio: Sprite = new Icon(Icon.MUTE, 32, 0xFFFFFF, 0.85);
      Helpers.withPointer(audio).addEventListener(MouseEvent.CLICK, function(e: MouseEvent): void {
        var textField: TextField = e.currentTarget.getChildByName(Icon.MUTE) as TextField;
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

      share.addEventListener(MouseEvent.CLICK, function(e: Event): void {
        if (e.target.name == Icon.TWITTER) {
          Helpers.open("https://twitter.com/share?" + [
            "url=" + escape(loaderInfo.parameters.url),
            "text=" + escape(loaderInfo.parameters.text),
            "related=vineapp"
          ].join("&"));
        } else if (e.target.name == Icon.EMBED) {
          Helpers.open(loaderInfo.parameters.url + "/embed");
        }
      });

      var details: Details = new Details(
        loaderInfo.parameters.name,
        loaderInfo.parameters.avatar,
        loaderInfo.parameters.text,
        loaderInfo.parameters.date,
        loaderInfo.parameters.location,
        PLAYER_SIZE
      );

      share.visible = false;
      details.addEventListener(MouseEvent.CLICK, function(e: Event): void {
        if (e.target.name == "shareLink") share.visible = !share.visible;
      });

      var player: Sprite = new Sprite();
      player.addChild(Helpers.fill(PLAYER_SIZE, PLAYER_SIZE, 0x000000, 1));
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
