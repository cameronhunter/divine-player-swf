package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class Share extends Sprite {

    private static const BACKGROUND_OPACITY: Number = 0.8;
    private static const BACKGROUND_COLOR: uint = 0x000000;
    private static const SHARE_TEXT: TextFormat = new TextFormat("Arial", 96, 0xFFFFFF, true);

    public function Share(url: String, width: uint, height: uint) {
      if (!url) return;

      var share: Sprite = Helpers.sprite(Helpers.text("Share", SHARE_TEXT));

      var twitter: Sprite = new ShareButton("Twitter", "\ue601", url);
      var href: Sprite = new ShareButton("Link", "\ue600", url);

      var background: Sprite = Helpers.fill(width, height, BACKGROUND_COLOR, BACKGROUND_OPACITY);
      var shareText: Sprite = Layout.absolute(30, 15, share);
      var shareButtons: Sprite = Layout.fitVertically(height, Layout.fitHorizontally(width, twitter, href));

      addChild(background);
      addChild(shareButtons);
      addChild(shareText);
    }

  }

}
