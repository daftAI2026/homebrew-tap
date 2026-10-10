class Incodex < Formula
  desc "Incognito toggle for the Codex desktop app"
  homepage "https://github.com/daftAI2026/incodex"
  version "1.4.0"
  license "MIT"

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-arm64"
    sha256 "1bc532edfe3bab333b67eacdeb3d0ee3edc661256677ca20681fa9c69b4d2d02"
  elsif Hardware::CPU.intel?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-x64"
    sha256 "72acf65d40ec51723664ec8d5ee3b883e8619824ebc3256c40c9426fd6cfe4a3"
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
