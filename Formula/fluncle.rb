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
  # A colon, not an em dash: `brew info fluncle` prints this to a stranger, and VOICE.md §6
  # sanctions exactly one em dash (the `Artist — Title` tracklist separator).
  desc "Drum & bass bangers from another dimension: the Fluncle CLI"
  homepage "https://www.fluncle.com"
  version "0.259.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-arm64"
      sha256 "30ebf105b4af418f6b8311a89ec5f387a1c4ae47d2d28b775f891c39f9cc53cc"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-x64"
      sha256 "817a2b5c973043c883bcde52a525459c523bd0c3ba0a8621c782ce9c30236901"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-arm64"
      sha256 "c867bf132228866c2e1ee8012ef17b2f831219eed4d9d96310f6c19e59f00542"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-x64"
      sha256 "64caa356ebcf0da3af134fff9f0defb35e7e9c09517b7e47a95934c7522a8eec"
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
