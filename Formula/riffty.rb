class Riffty < Formula
  desc "Deterministic, type-aware Python bug detector, surgical auto-fixer, and MCP diff reviewer"
  homepage "https://github.com/riffty-sh/riffty"
  url "https://github.com/riffty-sh/riffty.git",
      tag:      "v0.2.0"
  license "MIT"
  head "https://github.com/riffty-sh/riffty.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "apps/riffty_cli")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/riffty --version")
  end
end
