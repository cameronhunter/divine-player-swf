package {
  import asunit.framework.TestSuite;

  public class Suite extends TestSuite {
    public function Suite() {
      super();
      addTest(new PlayerTest("testPass"));
      addTest(new UriTest("test_isSafe"));
    }
  }
}
