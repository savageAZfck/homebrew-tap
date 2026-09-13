class SovereignLedger < Formula
  desc "Hardened hash-chained audit ledger: HMAC entries, Merkle proofs, Secure Enclave anchors"
  homepage "https://github.com/savageAZfck/sovereign_ledger"
  url "https://github.com/savageAZfck/sovereign_ledger/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "cc7ed188a009a6134aba03dfc04d31b8c0cd7394b0ce942ba1df5d2626114c97"
  license :cannot_represent

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--locked"
    bin.install "target/release/sovereign_ledger"
  end

  test do
    ENV["SOVEREIGN_LEDGER_KEY"] = "test-seed"
    system bin/"sovereign_ledger", testpath/"audit.jsonl", "init"
    system bin/"sovereign_ledger", testpath/"audit.jsonl", "append", "test", "hello"
    output = shell_output("#{bin}/sovereign_ledger #{testpath}/audit.jsonl verify")
    assert_match "chain valid", output
  end
end
