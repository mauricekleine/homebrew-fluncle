# Homebrew formula for the Fluncle CLI.
#
# Pulls the prebuilt Bun --compile binaries published to GitHub Releases by the
# `CLI Release` workflow (apps/cli assets `fluncle-<os>-<arch>`). No build step:
# each platform downloads its standalone binary and installs it as `fluncle`.
#
# This file lives in the mauricekleine/fluncle monorepo as the canonical source.
# It is copied into the tap repo `mauricekleine/homebrew-fluncle` as
# `Formula/fluncle.rb`. See README.md in this directory for seeding + bumping.
#
# To refresh for a new release vX.Y.Z, set `version` and replace each `sha256`
# with the checksum of the matching release asset (see README for a one-liner,
# or use `brew bump-formula-pr`).
class Fluncle < Formula
  desc "Drum & bass bangers from another dimension — the Fluncle CLI"
  homepage "https://www.fluncle.com"
  version "0.158.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-arm64"
      sha256 "65ce05cf7bc1f169e85013ddb3d23ff23c99373de7cfab0039f21ae53d7e957a"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-x64"
      sha256 "e7212abf1a00593c487ca22e3fac3f6793d9a4d6e6265e59d39307b2840b92ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-arm64"
      sha256 "5e761e351347402a457bcf3dab5fdea490f454563980ff305358d389c571bcf7"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-x64"
      sha256 "a161781105d55fec388fca006c81cde8c0d02da6b6349a7a2f5c36259df5f32f"
    end
  end

  def install
    # The release asset is the raw binary, named per-platform. Install it as `fluncle`.
    binary = Dir["fluncle-*"].first || "fluncle"
    bin.install binary => "fluncle"
  end

  test do
    assert_match "fluncle #{version}", shell_output("#{bin}/fluncle version")
  end
end
