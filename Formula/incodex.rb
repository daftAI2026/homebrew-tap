class Incodex < Formula
  desc "Incognito toggle for the Codex desktop app"
  homepage "https://github.com/daftAI2026/incodex"
  version "1.3.2"
  license "MIT"

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-arm64"
    sha256 "f0cdc6c9b378d0862822063342649aa11c9b1638d3ef8b092b6871f548077c01"
  elsif Hardware::CPU.intel?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-x64"
    sha256 "e034680b2acf1139033ecebf1b0957f409698e0a1a391240fe3bd0571f0cb4c9"
  else
    odie "Incodex currently ships macOS Intel and Apple Silicon binaries only"
  end

  def install
    bin.install Dir["incodex-darwin-*"].first => "incodex"
    bin.install_symlink "incodex" => "inc"
  end

  def caveats
    <<~EOS
      brew install only puts the CLI on PATH. Patching Codex still
      needs `incodex install`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/incodex --version")
    assert_match "incodex", shell_output("#{bin}/inc --help")
  end
end
