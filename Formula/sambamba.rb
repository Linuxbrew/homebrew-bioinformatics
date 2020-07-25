class Sambamba < Formula
  # cite Tarasov_2015: "https://doi.org/10.1093/bioinformatics/btv098"
  desc "Tools for working with SAM/BAM data"
  homepage "https://lomereiter.github.io/sambamba/"
  url "https://github.com/biod/sambamba.git",
      :tag      => "v0.7.1",
      :revision => "851c5b5a9ffe1895d860900104122ab81bb89f21"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any
    sha256 "70df7afcd3a125442c3303e85d1af3608a3ecb317783f3da81094dc3d12ae33a" => :sierra
    sha256 "d82fb6275ee8f516ed30c6d0797adf2ce5acb504f81fd5888bbaa367555dae7e" => :x86_64_linux
  end

  depends_on "ldc" => :build
  depends_on "python@3.8" => :build

  uses_from_macos "zlib"

  def install
    system "make", "release"
    system "make", "check"
    bin.install "bin/sambamba-#{version}" => "sambamba"
    pkgshare.install "BioD/test/data/ex1_header.bam"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/sambamba --help 2>&1", 1)
    system "#{bin}/sambamba",
      "sort", "-t2", "-n", "#{pkgshare}/ex1_header.bam",
      "-o", "ex1_header.nsorted.bam", "-m", "200K"
    assert_predicate testpath/"ex1_header.nsorted.bam", :exist?
  end
end
