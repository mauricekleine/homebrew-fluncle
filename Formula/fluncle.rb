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
  version "0.124.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-arm64"
      sha256 "ff86b3cceef7ac70101ac7315602b4f1b0735c60cf25b2e023b89132cc40071e"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-x64"
      sha256 "634bfe401a97f715ba2e7adad36f5803ff403038ab6f48f0d6e3f139f1d21794"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-arm64"
      sha256 "9c4a30b789c878c1db37d05d6519f9d45346fbb06c85aa723904f00202cc955f"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-x64"
      sha256 "149ef55b0fbfda26c07f3df534c13c1bf398b06fdc46eab415eb791d7f458de6"
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
