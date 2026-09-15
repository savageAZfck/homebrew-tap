class Respawn < Formula
  desc "Versioned state fabric (beta): content-addressed snapshots, atomic revert, drift detection, LAN sync"
  homepage "https://github.com/savageAZfck/respawn-releases"
  url "https://github.com/savageAZfck/respawn-releases/releases/download/v0.2.0/respawn-v0.2.0-macos-universal.tar.gz"
  sha256 "d14042cd0b9a0f2264373dd25fe0e641df5884f575b6e01ff9a70c6b829cfd86"
  version "0.2.0-beta"
  license "FSL-1.1-ALv2"

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
