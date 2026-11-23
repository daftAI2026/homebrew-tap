class Gay < Formula
  desc "Zero-overhead cross-platform CLI trampoline for agy"
  homepage "https://github.com/daftAI2026/gay-cli"
  url "https://github.com/daftAI2026/gay-cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "41e9817ab929021f3ec59d21c821d9178a3e9f378c8339e0101c9806793438df"
  license "MIT"

  def install
    bin.install "bin/gay"
  end

  def caveats
    <<~EOS
      gay requires the `agy` CLI (https://github.com/google-antigravity/antigravity-cli)
      to be installed and available in your PATH.
    EOS
  end

  test do
    (testpath/"agy").write <<~SH
      #!/bin/sh
      printf '%s\n' "$@"
    SH
    chmod 0755, testpath/"agy"

    output = shell_output("PATH=#{testpath}:$PATH #{bin}/gay --yolo -c")
    assert_equal "--dangerously-skip-permissions\n-c\n", output
  end
end
