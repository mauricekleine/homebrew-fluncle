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
  version "0.168.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-arm64"
      sha256 "c8462588f4177e181f6660078d729b467bcd79a3bbc275502c053ff73ba3bc1e"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-x64"
      sha256 "b95995b09056d99ac65640c63b9038846e743592ca951cea28119c28c4cdd48a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-arm64"
      sha256 "6b05e310e9f0f836dc051efa2121cc044b53c625db74fd42218ad61bc007f5ab"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-x64"
      sha256 "f297d1a4c64448bec0e427ff268c698162180dd4618b7411291ba57a6cdce3b8"
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
