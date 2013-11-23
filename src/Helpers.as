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

    public static function multiline(width: uint, parts: Array): TextField {
      var field: TextField = new TextField();
      field.autoSize = TextFieldAutoSize.LEFT;
      field.antiAliasType = AntiAliasType.ADVANCED;

      var part: Object;

      for each(part in parts) {
        field.text = field.text ? field.text + " " + part.text : part.text;
      }

      var start: uint = 0;
      for each(part in parts) {
        field.setTextFormat(part.format, start, start + part.text.length + 1);
        start += part.text.length;
      }

      field.selectable = false;
      field.multiline = false;
      field.wordWrap = true;
      field.height = field.textHeight;
      field.width = width;
      return field;
    }

    public static function text(text: String, format: TextFormat, embedFonts: Boolean = false, name: String = undefined): TextField {
      var field: TextField = new TextField();
      if (embedFonts) field.embedFonts = true;
      if (name) field.name = name;
      field.autoSize = TextFieldAutoSize.LEFT;
      field.antiAliasType = AntiAliasType.ADVANCED;
      field.defaultTextFormat = format;
      field.selectable = false;
      field.text = text;
      field.width = field.textWidth;
      field.height = field.textHeight;
      return field;
    }

    public static function link(object: Sprite, url: String, alwaysUnderline: Boolean = false): Sprite {
      object.addEventListener(MouseEvent.CLICK, function(e: Event): void {
        navigateToURL(new URLRequest(url), "_blank");
      });
      return withPointer(withUnderline(object, alwaysUnderline));
    }

    public static function withUnderline(object: Sprite, alwaysUnderline: Boolean = false): Sprite {
      for(var i: uint = 0; i < object.numChildren; i++) {
        if (object.getChildAt(i) is TextField) {
          var textField: TextField = object.getChildAt(i) as TextField;
          if (alwaysUnderline) {
            setUnderline(textField, true)();
          } else {
            object.addEventListener(MouseEvent.ROLL_OVER, setUnderline(textField, true));
            object.addEventListener(MouseEvent.ROLL_OUT, setUnderline(textField, false));
          }
        }
      }
      return object;
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

    private static function setUnderline(textField: TextField, value: Boolean): Function {
      return function(): void {
        var format: TextFormat = textField.getTextFormat();
        format.underline = value;
        textField.setTextFormat(format);
      };
    }

  }
}
