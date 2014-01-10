package {

  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.external.ExternalInterface;
  import flash.system.Security;
  import uk.co.cameronhunter.as3.components.Video;
  import uk.co.cameronhunter.as3.components.Image;
  import uk.co.cameronhunter.as3.utils.Logger;

  public class Player extends Sprite {

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

      addChildAt(poster, 0);
      addChildAt(video, 1);

      registerJavaScriptAPI(video);

      onReady();
    }

    private function onReady(): void {
      if (isSafe(ExternalInterface.objectID)) {
        ExternalInterface.call(["divinePlayer", ExternalInterface.objectID, "onReady"].join("_"));
      }
    }

    private function registerJavaScriptAPI(video: Video): void {
      ExternalInterface.addCallback("divinePlay", video.play);
      ExternalInterface.addCallback("divinePause", video.pause);
      ExternalInterface.addCallback("divinePaused", video.isPaused);
      ExternalInterface.addCallback("divineMute", video.mute);
      ExternalInterface.addCallback("divineUnmute", video.unmute);
      ExternalInterface.addCallback("divineMuted", video.isMuted);
      ExternalInterface.addCallback("divineDuration", video.duration);
      ExternalInterface.addCallback("divineCurrentTime", video.currentTime);
    }

    private function isSafe(value: String): Boolean {
      return /^[0-9A-Z]+$/i.test(value);
    }
  }
}
