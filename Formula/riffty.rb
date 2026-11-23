class Riffty < Formula
  desc "Self-contained multi-language software remediation (Python, JS/TS, Java Tier 1+2), riffty-ab, and infra cost intelligence"
  homepage "https://github.com/riffty-sh/riffty"
  url "https://github.com/riffty-sh/riffty.git",
      tag:      "v0.3.1"
  license "MIT"
  head "https://github.com/riffty-sh/riffty.git", branch: "main"

  depends_on "maven" => :build
  depends_on "openjdk@25" => :build
  depends_on "rust" => :build

  def install
    ENV["JAVA_HOME"] = Formula["openjdk@25"].opt_libexec/"openjdk.jdk/Contents/Home"
    system "bash", "plugins/riffty-java/package_jlink_aot.sh"
    (libexec/"riffty-java").install Dir["plugins/riffty-java/dist/*"]

    system "cargo", "install", *std_cargo_args(path: "apps/riffty_cli")
    system "cargo", "install", *std_cargo_args(path: "apps/riffty_ab")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/riffty --version")
    assert_match version.to_s, shell_output("#{bin}/riffty-ab --version")
    assert_predicate libexec/"riffty-java/riffty-java-runner.jar", :exist?
    assert_predicate libexec/"riffty-java/runtime/bin/java", :exist?
  end
end
