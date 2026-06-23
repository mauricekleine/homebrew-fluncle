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
  version "0.55.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-arm64"
      sha256 "6fc0636fcf2cfc17a971087c23bfd260e64eba30d36e22eef09dcbfbbe2b2cc4"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-darwin-x64"
      sha256 "ee910bd6ad0f95f23657ea6bf5eee853752b715703ccc1c37a2dd4a422631d09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-arm64"
      sha256 "8ccf4d73bb6910ca5bdcb884b2c529f8281550b88848f362ff40253521ed2596"
    end
    on_intel do
      url "https://github.com/mauricekleine/fluncle/releases/download/v#{version}/fluncle-linux-x64"
      sha256 "3a2086a7152a858eeaa32e0390ed9a8dd2e184dda73ab79aff69649ea79eb93c"
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
