/**
 * NOTE: Tests have to be manually added to Suite.as
 */
package {
  import asunit.framework.TestCase;

  public class UriTest extends TestCase {

    public function UriTest(testMethod: String) {
      super(testMethod);
    }

    public function test_isSafe(): void {
      assertThrows(Error, function(): void {
        Uri.isSafe("https://vine.co%00@masatoxss.appspot.com#alert(location)");
      });

      assertEquals("Safe URL", Uri.isSafe("https://vine.co/foo.jpg"), "https://vine.co/foo.jpg");
    }

  }

}
