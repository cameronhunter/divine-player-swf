package {

  import flash.display.Sprite;

  public class Avatar extends Sprite {

    public function Avatar(url: String, size: uint) {
      var circle: Sprite = Helpers.circle(size);
      var avatar: Sprite = new Image(url, size, size);

      avatar.mask = circle;

      addChild(circle);
      addChild(avatar);
    }

  }

}
