class StateFabric < Formula
  desc "Versioned state fabric (beta): content-addressed snapshots, atomic revert, drift detection, LAN sync"
  homepage "https://github.com/savageAZfck/state-fabric-releases"
  url "https://github.com/savageAZfck/state-fabric-releases/releases/download/v0.1.0/state_fabric-v0.1.0-macos-universal.tar.gz"
  sha256 "b9489959083e717880781aae42c6e9233d741bed5adb770ac60feff32fbc2376"
  version "0.1.0-beta"
  license :cannot_represent

  depends_on :macos

  def install
    bin.install "state_fabric"
  end

  test do
    mkdir "proj" do
      system bin/"state_fabric", "init"
      (testpath/"proj/file.txt").write("hello")
      system bin/"state_fabric", "snap", "-m", "v1"
      (testpath/"proj/file.txt").write("changed")
      system bin/"state_fabric", "revert", "head", "--force"
      assert_equal "hello", (testpath/"proj/file.txt").read
    end
  end
end
