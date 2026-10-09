class Incodex < Formula
  desc "Incognito toggle for the Codex desktop app"
  homepage "https://github.com/daftAI2026/incodex"
  version "1.3.1"
  license "MIT"

  depends_on :macos

  if Hardware::CPU.arm?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-arm64"
    sha256 "4c1841c19576e3de660949860162569ddb4464803cabee494f51f6065db33a56"
  elsif Hardware::CPU.intel?
    url "https://github.com/daftAI2026/incodex/releases/download/v#{version}/incodex-darwin-x64"
    sha256 "dcf3bf42804272a7e0a17fe2376d114abb058ffc5ca1d9d05b240b6276bc6af2"
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
