class EdgeGate < Formula
  desc "Local LLM edge gateway: dedup, blind, filter, meter, audit"
  homepage "https://github.com/savageAZfck/edge_gate"
  url "https://github.com/savageAZfck/edge_gate/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2efb70caaf7b3666f2441ebf619f4050141716fbf3494e1ae658bc8a4c629883"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "build", "--release", "--locked"
    bin.install "target/release/edge_gate"
    etc.install "edge_gate.toml" => "edge_gate.toml"
  end

  test do
    (testpath/"ledger.jsonl").write("")
    system bin/"edge_gate", "verify", "--ledger", testpath/"ledger.jsonl"
  end
end
