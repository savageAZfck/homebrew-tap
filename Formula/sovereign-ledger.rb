class SovereignLedger < Formula
  desc "Hardened hash-chained audit ledger: HMAC entries, Merkle proofs, Secure Enclave anchors"
  homepage "https://github.com/savageAZfck/sovereign_ledger"
  url "https://github.com/savageAZfck/sovereign_ledger/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "8a00f3ead03248dcd1f26b9296b7a3e3accdfb19aa241db88ae8558f4b9c4f46"
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
