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

    private static const WIDTH: uint = 480;
    private static const HEIGHT: uint = 640;

    private static const AUDIO_FORMAT: TextFormat = new TextFormat("standalone-player-font", 32, 0xFFFFFF);

    public function Player() {
      stage.align = StageAlign.TOP_LEFT;
      stage.scaleMode = StageScaleMode.NO_SCALE;

      Security.allowDomain("*");
      Security.allowInsecureDomain("*");

      var playerSize: uint = stage.stageWidth;
      var playerContainer: Sprite = new Sprite();

      var video: Video = new Video(
        loaderInfo.parameters.video,
        playerSize, playerSize,
        false, // autoplay
        true, // loop
        true // muted
      );

      var curtain: Sprite = new Curtain(loaderInfo.parameters.poster, playerSize, playerSize);
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

      var playPause: Sprite = Helpers.fill(playerSize, playerSize, 0x000000, 0);
      playPause.addEventListener(MouseEvent.CLICK, function(): void {
        video.isPaused() ? video.play() : video.pause();
      });

      var share: Share = new Share(
        loaderInfo.parameters.url || "http://cameronhunter.co.uk",
        playerSize, playerSize
      );

      var details: Details = new Details(
        loaderInfo.parameters.name || "Ian Padgham",
        loaderInfo.parameters.avatar || "https://v.cdn.vine.co/v/avatars/637F68B3-FE31-424F-BC88-E8AA4BF293CE-6199-0000041FF76BBB5A.jpg?versionId=1OKBqNZJwbvX1bxqI3sh22C4gpjsIUX4",
        loaderInfo.parameters.text || "Look at these horses run free. It makes me so very #happy",
        loaderInfo.parameters.date || 1385018455000,
        loaderInfo.parameters.location || "Edinburgh",
        stage.stageWidth,
        160
      );

      share.visible = false;
      details.addEventListener(MouseEvent.CLICK, function(): void {
        share.visible = true;
      });

      playerContainer.addChild(video);
      playerContainer.addChild(playPause);
      playerContainer.addChild(Layout.absolute(15, 15, audio));
      playerContainer.addChild(curtain);
      playerContainer.addChild(share);

      addChild(Layout.vertical(0, playerContainer, details));
    }

  }
}
