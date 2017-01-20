class Fatdisk < Formula
  desc "C code utility to modify DOS disks in place without mounting"
  homepage "https://goblinhack.github.io/fatdisk/"
  head "https://github.com/goblinhack/fatdisk.git"
  devel do
    url "https://github.com/goblinhack/fatdisk/archive/v1.0.0-beta.tar.gz"
    version "1.0.0-beta"
    sha256 "72b9e48910e907bb647f7c723dfc92e74b989025c8fe44f38c5b910992717e4c"
  end

  depends_on "makedepend" => :build

  def install
    system "./RUNME"

    bin.install "fatdisk.i386"
    mv bin/"fatdisk.i386", bin/"fatdisk"

    doc.install "LICENSE"
    doc.install "README.md"
    libexec.install "test/grub.img"
  end

  test do
    # Based on some tests from https://github.com/goblinhack/fatdisk/blob/master/TESTME
    ohai "Format 1G disk file with 2 DOS partitions and put grub in the MBR"
    system "#{bin}/fatdisk", "mydisk.img", "format", "name", "FATDISK", "size", "1G", "part", "0", "45%", "boot", "#{libexec}/grub.img", "part", "1", "40%", "fat32"

    ohai "Make sure fatdisk can inspect this file"
    system "#{bin}/fatdisk", "mydisk.img", "info"
    system "#{bin}/fatdisk", "mydisk.img", "summary"
  end
end
