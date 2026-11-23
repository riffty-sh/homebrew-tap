class Riffty < Formula
  desc "Deterministic multi-language software remediation (Python, JS/TS, Java), empirical A/B verification (riffty-ab), and infra cost intelligence"
  homepage "https://github.com/riffty-sh/riffty"
  url "https://github.com/riffty-sh/riffty.git",
      tag:      "v0.4.1"
  license "MIT"
  head "https://github.com/riffty-sh/riffty.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "apps/riffty_cli")
    system "cargo", "install", *std_cargo_args(path: "apps/riffty_ab")
  end

  def caveats
    <<~EOS
      Python (Tier 1+2), JS/TS (Tier 1+2), and Java (Tier 1) are built-in with zero external runtimes.
      Java Tier 2 (bundled JDK 25 + Leyden AOT + Error Prone/Picnic) auto-hydrates on first `.java` check,
      or can be pre-installed for offline/CI use via:
        riffty plugin install java
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/riffty --version")
    assert_match version.to_s, shell_output("#{bin}/riffty-ab --version")
    assert_match "python (Tier 1+2)", shell_output("#{bin}/riffty plugin status")
  end
end
