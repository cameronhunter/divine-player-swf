package {

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import flash.text.TextFieldAutoSize;
  import flash.text.AntiAliasType;

  public final class Icon extends Sprite {

    public static const EMBED: String = "\ue600";
    public static const TWITTER: String = "\ue601";
    public static const PLAY: String = "\ue602";
    public static const CLOSE: String = "\ue603";
    public static const MUTE: String = "\ue604";
    public static const UNMUTE: String = "\ue605";

    private static const FONT_NAME: String = "vine-icons";

    public function Icon(icon: String, size: uint, color: uint = 0xFFFFFF, opacity: Number = 1) {
      var field: TextField = new TextField();
      field.embedFonts = true;
      field.name = icon;
      field.autoSize = TextFieldAutoSize.LEFT;
      field.antiAliasType = AntiAliasType.ADVANCED;
      field.defaultTextFormat = new TextFormat(FONT_NAME, size, color);
      field.selectable = false;
      field.text = icon;
      field.width = field.textWidth;
      field.height = field.textHeight;

      this.alpha = opacity;

      addChild(field);
    }

  }

}