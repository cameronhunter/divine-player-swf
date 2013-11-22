package {

  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import flash.events.*;
  import flash.text.TextFormat;

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

    private static const AUDIO_FORMAT: TextFormat = new TextFormat("standalone-player-font", 28, 0xFFFFFF);

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

      var curtain: Sprite = new Sprite();
      //curtain.addChild(poster);

      var video: Video = new Video(
        loaderInfo.parameters.video,
        playerSize, playerSize,
        false, // autoplay
        true, // loop
        false // muted
      );

      var playButton: Sprite = Layout.middle(playerSize, playerSize, new PlayerControl(Icon.PLAY));
      var pauseButton: Sprite = Helpers.withPointer(Helpers.fill(playerSize, playerSize, 0x000000, 0));

      var muteButton: Sprite = Helpers.withPointer(Helpers.withOpacity(0.85, Layout.absolute(15, 15, Helpers.sprite(Helpers.text(Icon.MUTE, AUDIO_FORMAT, true)))));
      var unmuteButton: Sprite = Helpers.withPointer(Helpers.withOpacity(0.85, Layout.absolute(15, 15, Helpers.sprite(Helpers.text(Icon.UNMUTE, AUDIO_FORMAT, true)))));

      muteButton.addEventListener(MouseEvent.CLICK, function(): void {
        video.mute();
        unmuteButton.visible = true;
        playerContainer.swapChildren(muteButton, unmuteButton);
      });

      unmuteButton.addEventListener(MouseEvent.CLICK, function(): void {
        video.unmute();
        muteButton.visible = true;
        playerContainer.swapChildren(muteButton, unmuteButton);
      });

      muteButton.visible = unmuteButton.visible = false;

      playButton.addEventListener(MouseEvent.CLICK, function(): void {
        playButton.visible = false;
        muteButton.visible = unmuteButton.visible = true;
        video.play();
      });

      pauseButton.addEventListener(MouseEvent.CLICK, function(): void {
        if (video.isPaused()) {
          video.play();
        } else {
          video.pause();
        }
      });

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

      playerContainer.addChild(unmuteButton);
      playerContainer.addChild(video);
      playerContainer.addChild(pauseButton);
      playerContainer.addChild(muteButton);
      playerContainer.addChild(playButton);
      //playerContainer.addChild(share);

      addChild(Layout.vertical(0, playerContainer, details));
    }

  }
}
