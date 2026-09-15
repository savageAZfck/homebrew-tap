class EdgeGate < Formula
  desc "Local LLM edge gateway (beta): dedup, blind, filter, meter, audit"
  homepage "https://github.com/savageAZfck/edge-gate-releases"
  url "https://github.com/savageAZfck/edge-gate-releases/releases/download/v0.1.0/edge_gate-0.1.0-aarch64-apple-darwin.tar.gz"
  sha256 "8a29f4ee933a0a11df3a2f5bc0009e17d2d73b24569ff52c5b2b13bf6e70786d"
  version "0.1.0-beta"
  license "FSL-1.1-ALv2"

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "edge_gate"
  end

  test do
    (testpath/"ledger.jsonl").write("")
    system bin/"edge_gate", "verify", "--ledger", testpath/"ledger.jsonl"
  end
end
