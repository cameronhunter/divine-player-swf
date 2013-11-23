package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.events.*;

  public class Share extends Sprite {

    private static const BACKGROUND_OPACITY: Number = 0.6;
    private static const BACKGROUND_COLOR: uint = 0x000000;
    private static const SHARE_TEXT: TextFormat = new TextFormat("Helvetica, Arial", 56, 0xFFFFFF, true);
    private static const LINK_TEXT: TextFormat = new TextFormat("Helvetica, Arial", 16, 0xFFFFFF, true);
    private static const CLOSE_FORMAT: TextFormat = new TextFormat("standalone-player-font", 18, 0xFFFFFF);

    private static const TWITTER_COLOR: uint = 0x01ACED;
    private static const EMBED_COLOR: uint = 0x00BF8F;

    public function Share(url: String, width: uint, height: uint) {
      if (!url) return;

      var share: Sprite = Helpers.sprite(Helpers.text("Share", SHARE_TEXT));

      var linkText: Sprite = Helpers.link(Helpers.sprite(Helpers.text(url, LINK_TEXT)), url, true);
      var arrow: Sprite = Helpers.sprite(Helpers.text("→", LINK_TEXT));

      var link: Sprite = Layout.horizontal(0, linkText, arrow);

      var twitter: Sprite = new ShareButton("Twitter", Icon.TWITTER, url, TWITTER_COLOR);
      var embed: Sprite = new ShareButton("Embed", Icon.EMBED, url, EMBED_COLOR);

      var background: Sprite = Helpers.fill(width, height, BACKGROUND_COLOR, BACKGROUND_OPACITY);
      var shareButtons: Sprite = Layout.fitVertically(height, Layout.fitHorizontally(width, twitter, embed));

      var closeButton: Sprite = Helpers.withOpacity(0.85, Helpers.withPointer(Helpers.sprite(Helpers.text(Icon.CLOSE, CLOSE_FORMAT, true))));
      closeButton.addEventListener(MouseEvent.CLICK, function(): void {
        visible = false;
      });

      addChild(background);
      addChild(shareButtons);
      addChild(Layout.absolute(15, 15, Layout.vertical(0, share, link)));
      addChild(Layout.absolute(width - (5 + closeButton.width), 5, closeButton));
    }

  }

}
