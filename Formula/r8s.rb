class R8s < Formula
  # cite Sanderson_2003: "https://doi.org/10.1093/bioinformatics/19.2.301"
  desc "Estimate rates and divergence times on phylogenetic trees"
  homepage "https://ceiba.biosci.arizona.edu/r8s/"
  url "https://ceiba.biosci.arizona.edu/r8s/r8s.dist.tgz"
  version "1.8"
  sha256 "3b70c86c5aeff52b42598bd48777881b22104c1c1c4658ebcf96d2da9d9521b4"

  depends_on "gcc" # for gfortran

  def install
    # Tell r8s where libgfortran is located
    obj_name = OS.linux? ? "libgfortran.so" : "libgfortran.dylib"
    fortran_lib = File.dirname `gfortran --print-file-name #{obj_name}`
    inreplace "makefile" do |s|
      s.change_make_var! "LPATH", "-L#{fortran_lib}"
      s.gsub! %r{/usr/include/\S+}, "" # get rid of makefile deps on system headers
    end
    system "make"
    bin.install "r8s"
    pkgshare.install Dir["SAMPLE_*", "*.pdf"]
  end

  test do
    assert_match "r8s version #{version}", shell_output("#{bin}/r8s -v -b", 1)
  end
end
