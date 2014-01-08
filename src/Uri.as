package {

  public class Uri {

    public static function isSafe(url: String): String {
      // Empty or null String
      if (!url) throw new Error("URL is null or empty");

      // Prevent NULL character attack
      if (url.indexOf("\\x00") >= 0) throw new Error("URL contains a NULL character");

      return url;
    }

  }

}