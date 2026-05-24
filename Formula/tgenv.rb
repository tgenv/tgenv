class Tgenv < Formula
  desc "Tool to manage multiples Terragrunt versions"
  homepage "https://github.com/tgenv/tgenv"
  url "https://github.com/tgenv/tgenv/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "241b18ee59bd993256c9dc0847e23824c9ebf42b4d121db11fbdff9ddb6432b2"
  license "MIT"
  head "https://github.com/tgenv/tgenv.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  uses_from_macos "unzip"

  conflicts_with "tenv", because: "tgenv symlinks terragrunt binaries"
  conflicts_with "terragrunt", because: "tgenv symlinks terragrunt binaries"
  conflicts_with "tgenv", because: "tgenv homebrew-core package is unmaintained"

  def install
    prefix.install %w[bin libexec]
  end

  test do
    assert_match "0.58.1", shell_output("#{bin}/tgenv list-remote")
  end
end
