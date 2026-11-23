class Gay < Formula
  desc "Zero-overhead cross-platform CLI trampoline for agy"
  homepage "https://github.com/daftAI2026/gay-cli"
  url "https://github.com/daftAI2026/gay-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "795f26371e016232dceea7291d3f6f97af8bff00de592c6d598d14fdf46eb890"
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
