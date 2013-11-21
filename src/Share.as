package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class Share extends Sprite {

    private static const BACKGROUND_OPACITY: Number = 0.8;
    private static const BACKGROUND_COLOR: uint = 0x000000;
    private static const SHARE_TEXT: TextFormat = new TextFormat("Arial", 96, 0xFFFFFF, true);

    private static const TWITTER_COLOR: uint = 0x01ACED;
    private static const LINK_COLOR: uint = 0xC7476C;

    public function Share(url: String, width: uint, height: uint) {
      if (!url) return;

      var share: Sprite = Helpers.sprite(Helpers.text("Share", SHARE_TEXT));

      var twitter: Sprite = Layout.scale(new ShareButton("Twitter", "\ue601", url, TWITTER_COLOR), 1.2);
      var href: Sprite = Layout.scale(new ShareButton("Link", "\ue600", url, LINK_COLOR), 1.2);

      var background: Sprite = Helpers.fill(width, height, BACKGROUND_COLOR, BACKGROUND_OPACITY);
      var shareText: Sprite = Layout.absolute(30, 15, share);
      var shareButtons: Sprite = Layout.fitVertically(height, Layout.fitHorizontally(width, twitter, href));

      addChild(background);
      addChild(shareButtons);
      addChild(shareText);
    }

  }

}
