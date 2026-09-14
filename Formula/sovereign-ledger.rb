class SovereignLedger < Formula
  desc "Hardened hash-chained audit ledger (beta): HMAC entries, Merkle proofs, Secure Enclave anchors"
  homepage "https://github.com/savageAZfck/sovereign_ledger"
  url "https://github.com/savageAZfck/sovereign_ledger/releases/download/v0.3.1/sovereign_ledger-v0.3.1-macos-universal.tar.gz"
  sha256 "108c123abb78e230937312a38dd65298df7711be017b86bcbb2f4606beb2a5d5"
  version "0.3.1-beta"
  license :cannot_represent

  def install
    bin.install "sovereign_ledger"
  end

  test do
    ENV["SOVEREIGN_LEDGER_KEY"] = "test-seed"
    system bin/"sovereign_ledger", testpath/"audit.jsonl", "init"
    system bin/"sovereign_ledger", testpath/"audit.jsonl", "append", "test", "hello"
    output = shell_output("#{bin}/sovereign_ledger #{testpath}/audit.jsonl verify")
    assert_match "chain valid", output
  end
end
