class Riffty < Formula
  desc "Deterministic multi-language software remediation, empirical A/B verification (riffty-ab), and infrastructure cost intelligence"
  homepage "https://github.com/riffty-sh/riffty"
  url "https://github.com/riffty-sh/riffty.git",
      tag:      "v0.3.0"
  license "MIT"
  head "https://github.com/riffty-sh/riffty.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "apps/riffty_cli")
    system "cargo", "install", *std_cargo_args(path: "apps/riffty_ab")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/riffty --version")
    assert_match version.to_s, shell_output("#{bin}/riffty-ab --version")
  end
end
