class Incodex < Formula
  desc "Incognito toggle for the Codex desktop app"
  homepage "https://github.com/daftAI2026/incodex"
  version "0.4.0"
  license "MIT"

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-arm64"
    sha256 "74be431b2b73a377be7b3185a4410447108783da8790afd3997edf6b91d00c68"
  elsif Hardware::CPU.intel?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-x64"
    sha256 "01f61ffacada940638c16fe6ba460eb9dcb479c9334bc6afc6e3ce0a1e865026"
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
