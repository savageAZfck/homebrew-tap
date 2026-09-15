class Respawn < Formula
  desc "Versioned state fabric (beta): content-addressed snapshots, atomic revert, drift detection, LAN sync"
  homepage "https://github.com/savageAZfck/respawn-releases"
  url "https://github.com/savageAZfck/respawn-releases/releases/download/v0.1.0/respawn-v0.1.0-macos-universal.tar.gz"
  sha256 "7a05dc328bae76725b9e052913d3753abd98b9a9746a29e4242000d2ec49cd5f"
  version "0.1.0-beta"
  license :cannot_represent

  depends_on :macos

  def install
    bin.install "respawn"
  end

  test do
    mkdir "proj" do
      system bin/"respawn", "init"
      (testpath/"proj/file.txt").write("hello")
      system bin/"respawn", "snap", "-m", "v1"
      File.write(testpath/"proj/file.txt", "changed")
      system bin/"respawn", "revert", "head", "--force"
      assert_equal "hello", (testpath/"proj/file.txt").read
    end
  end
end
