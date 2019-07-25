class Viennarna < Formula
  # cite Lorenz_2011: "https://doi.org/10.1186/1748-7188-6-26"
  desc "Prediction and comparison of RNA secondary structures"
  homepage "https://www.tbi.univie.ac.at/~ronny/RNA/"
  url "https://www.tbi.univie.ac.at/RNA/download/sourcecode/2_4_x/ViennaRNA-2.4.13.tar.gz"
  sha256 "915c271b48536a3cc60b3109f11f7fd99dcd26d22621ee50f05e7f1c2f90cabe"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    sha256 "4fba00c07584848dd8b2bd82377217cdcc7393cfe890255673a3ddb66234491f" => :sierra
    sha256 "7f6a88b2c3855a40255ed707bd2596e10a24c80bcd007453440d0d561828ee9f" => :x86_64_linux
  end

  depends_on "gcc" if OS.mac? # for OpenMP
  depends_on "python@2"

  fails_with :clang # needs OpenMP

  def install
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--with-python",
      "--prefix=#{prefix}"
    system "make"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    assert_match "-1.30 MEA=21.31", pipe_output("#{bin}/RNAfold --MEA", "CGACGUAGAUGCUAGCUGACUCGAUGC")
  end
end
