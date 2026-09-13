class SovereignLedger < Formula
  desc "Hardened hash-chained audit ledger: HMAC entries, Merkle proofs, Secure Enclave anchors"
  homepage "https://github.com/savageAZfck/sovereign_ledger"
  url "https://github.com/savageAZfck/sovereign_ledger/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "b7822c7b976aeb82639ec4c803e1ef9de0c444eae6ec159985a752b89f417c88"
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
