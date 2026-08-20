class Incodex < Formula
  desc "Incognito toggle for the Codex desktop app"
  homepage "https://github.com/daftAI2026/incodex"
  version "0.3.1"
  license "MIT"

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-arm64"
    sha256 "20b356ebe9939aacf86fbe60c212a0ef675ac790819f0a727dbb44725404e058"
  elsif Hardware::CPU.intel?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-x64"
    sha256 "64d8df4a34f4317959386910f82ce2538f98889fd700d9ac0b1ca4e8d0a7123e"
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
