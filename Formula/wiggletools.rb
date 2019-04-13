class Wiggletools < Formula
  desc "Compute genome-wide statistics with composable iterators"
  homepage "https://github.com/Ensembl/WiggleTools"
  url "https://github.com/Ensembl/WiggleTools/archive/v1.2.3.tar.gz"
  sha256 "2adc6c0f1738e604aa20a60b1c79ea36bc8cd030a2b6039b8e5ddc31c2bf846c"
  head "https://github.com/Ensembl/WiggleTools.git"
  # doi "10.1093/bioinformatics/btt737"

  unless OS.mac?
    depends_on "curl"
    depends_on "zlib"
  end
  depends_on "gsl"
  depends_on "htslib"
  depends_on "libbigwig"
  depends_on "python@2"

  def install
    system "make"
    pkgshare.install "test"
    lib.install "lib/libwiggletools.a"
    bin.install "bin/wiggletools"
  end

  test do
    cp_r pkgshare/"test", testpath
    cp_r prefix/"bin", testpath
    cd "test" do
      system "python2", "test.py"
    end
  end
end
