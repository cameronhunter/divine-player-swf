package {

  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.*;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.text.AntiAliasType;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;

  public final class Helpers {

    public static function text(text: String, format: TextFormat = undefined, embedFonts: Boolean = false): TextField {
      var field: TextField = new TextField();
      if (embedFonts) field.embedFonts = true;
      field.autoSize = TextFieldAutoSize.LEFT;
      field.antiAliasType = AntiAliasType.ADVANCED;
      if (format) field.defaultTextFormat = format;
      field.selectable = false;
      field.text = text;
      field.width = field.textWidth + 4;
      field.height = field.textHeight + 4;
      return field;
    }

    public static function link(object: Sprite, url: String): Sprite {
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

      return withPointer(object);
    }

    public static function withOpacity(opacity: Number, object: Sprite): Sprite {
      object.alpha = opacity;
      return object;
    }

    public static function withPointer(object: Sprite): Sprite {
      object.useHandCursor = true;
      object.buttonMode = true;
      object.mouseChildren = false;
      return object;
    }

    public static function sprite(object: DisplayObject): Sprite {
      var wrapper: Sprite = new Sprite();
      wrapper.addChild(object);
      return wrapper;
    }

    public static function fill(width: uint, height: uint, color: uint = 0x000000, opacity: Number = 1): Sprite {
      var background: Sprite = new Sprite();
      background.graphics.beginFill(color, opacity);
      background.graphics.drawRect(0, 0, width, height);
      background.graphics.endFill();
      return background;
    }

    public static function circle(diameter: uint, color: uint = 0x000000, opacity: Number = 1): Sprite {
      var radius: Number = diameter / 2;
      var object: Sprite = new Sprite();
      object.graphics.beginFill(color, opacity);
      object.graphics.drawCircle(radius, radius, radius);
      object.graphics.endFill();
      return object;
    }

    public static function ring(diameter: uint, thickness: uint, color: uint = 0x000000, opacity: Number = 1): Sprite {
      var radius: Number = diameter / 2;
      var innerRadius: Number = radius - thickness;
      var object: Sprite = new Sprite();
      object.graphics.beginFill(color, opacity);
      object.graphics.drawCircle(radius, radius, radius);
      object.graphics.drawCircle(radius, radius, innerRadius);
      object.graphics.endFill();
      return object;
    }

    private static function setUnderline(textField: TextField, value: Boolean): Function {
      return function(e: Event): void {
        var format: TextFormat = textField.getTextFormat();
        format.underline = value;
        textField.setTextFormat(format);
      };
    }

  }
}
