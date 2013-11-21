package {

  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.*;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class Share extends Sprite {

    private static const BACKGROUND_OPACITY: Number = 0.8;
    private static const SHARE_TEXT: TextFormat = new TextFormat("Arial", 96, 0xFFFFFF, true);
    private static const SHARE_BUTTON: TextFormat = new TextFormat("Arial", 28, 0xFFFFFF, true);

    public function Share(url: String, width: uint, height: uint) {
      if (!url) return;

      var share: TextField = text("Share", SHARE_TEXT);

      var twitter: Sprite = link(createShareButton("Twitter", new Resource.TwitterIcon()), url);
      var email: Sprite = link(createShareButton("Email", new Resource.EmailIcon()), url);
      var embed: Sprite = link(createShareButton("Embed", new Resource.EmbedIcon()), url);

      var background: Sprite = createBackground(width, height, BACKGROUND_OPACITY);
      var shareText: Sprite = Layout.absolute(30, 15, share);
      var shareButtons: Sprite = Layout.fitVertically(height, Layout.fitHorizontally(width, twitter, email, embed));

      addChild(background);
      addChild(shareButtons);
      addChild(shareText);
    }

    private static function createBackground(width: uint, height: uint, opacity: Number = 1): Sprite {
      var background: Sprite = new Sprite();
      background.graphics.beginFill(0x000000, opacity);
      background.graphics.drawRect(0, 0, width, height);
      background.graphics.endFill();
      return background;
    }

    private static function createShareButton(name: String, icon: Bitmap): Sprite {
      var textField: TextField = text(name, SHARE_BUTTON);
      return Layout.centerHorizontally(Layout.vertical(10, icon, textField));
    }

    private static function text(text: String, format: TextFormat = undefined): TextField {
      var field: TextField = new TextField();
      field.text = text;
      if (format) field.setTextFormat(format);
      field.selectable = false;
      field.width = field.textWidth + 4;
      field.height = field.textHeight + 4;
      return field;
    }

    private static function link(object: Sprite, url: String): Sprite {
      object.useHandCursor = true;
      object.buttonMode = true;
      object.mouseChildren = false;

      object.addEventListener(MouseEvent.CLICK, function(e: Event): void {
        navigateToURL(new URLRequest(url), "_blank");
      });

      for(var i: uint = 0; i < object.numChildren; i++) {
        if (object.getChildAt(i) is TextField) {
          var textField: TextField = object.getChildAt(i) as TextField;
          object.addEventListener(MouseEvent.ROLL_OVER, setUnderline(textField, true));
          object.addEventListener(MouseEvent.ROLL_OUT, setUnderline(textField, false));
        }
      }

      return object;
    }

    private static function setUnderline(textField: TextField, value: Boolean): Function {
      return function(e: Event): void {
        var format: TextFormat = textField.getTextFormat();
        format.underline = value;
        textField.setTextFormat(format);
      };
    }

    private static function sprite(object: DisplayObject): Sprite {
      var wrapper: Sprite = new Sprite();
      wrapper.addChild(object);
      return wrapper;
    }

  }

}
