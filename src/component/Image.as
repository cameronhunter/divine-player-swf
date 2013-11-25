package component {

  import flash.display.Loader;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.net.URLRequest;

  public class Image extends Sprite {

    public function Image(url: String, width: uint, height: uint) {
      if (!url) return;

      var loader: Loader = new Loader();

      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e: Event): void {
        addChild(loader);
        loader.width = width;
        loader.height = height;
      });

      loader.load(new URLRequest(url));

      graphics.beginFill(0x000000, 0);
      graphics.drawRect(0, 0, width, height);
      graphics.endFill();
    }

  }

}
