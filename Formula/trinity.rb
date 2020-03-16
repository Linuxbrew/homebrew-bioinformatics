class Trinity < Formula
  # cite Grabherr_2011: "https://doi.org/10.1038/nbt.1883"
  desc "RNA-Seq de novo assembler"
  homepage "https://trinityrnaseq.github.io"
  url "https://github.com/trinityrnaseq/trinityrnaseq.git",
    :tag      => "v2.9.1",
    :revision => "6b57ddbc2ac96bef8635d8c86138b43b9b4cf87c"
  sha256 "1ca01e76989596815d53ee818ea031c19b44677eca2442b784503203ea9d92d5"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any
    sha256 "5e23769342aadb13867b85f482c8fd7e1cd55cac5a31d21a190217030ac8a756" => :sierra
    sha256 "ff67590d079efb957c3b2619afb2fa10f71cf1ebc9b54399f63a793aebf85fd8" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "bowtie2"
  depends_on "express"
  depends_on "gcc" if OS.mac? # for openmp
  depends_on "htslib"
  depends_on "jellyfish"
  depends_on "openjdk"
  depends_on "salmon"
  depends_on "samtools"
  depends_on "trimmomatic"

  # Trinity doesn't link to eXpress, which depends on Boost, built with C++11
  cxxstdlib_check :skip

  fails_with :clang # needs openmp

  def install
    inreplace "Trinity" do |s|
      s.gsub! "$ROOTDIR/trinity-plugins/Trimmomatic/trimmomatic.jar",
        Dir["#{Formula["trimmomatic"].libexec}/trimmomatic*"].first
      s.gsub! "$ROOTDIR/trinity-plugins/Trimmomatic",
        Formula["trimmomatic"].opt_prefix
    end

    inreplace "util/misc/run_jellyfish.pl",
      '$JELLYFISH_DIR = $FindBin::RealBin . "/../../trinity-plugins/jellyfish-1.1.3";',
      "$JELLYFISH_DIR = \"#{Formula["jellyfish"].opt_prefix}\";"

    system "make", "all", "plugins", "test"
    libexec.install Dir["*"]
    (bin/"Trinity").write_env_script(libexec/"Trinity", :PERL5LIB => libexec/"PerlLib")
  end

  test do
    cp_r Dir["#{libexec}/sample_data/test_Trinity_Assembly/*.fq.gz"], "."
    system "#{bin}/Trinity",
      "--no_distributed_trinity_exec", "--bypass_java_version_check",
      "--seqType", "fq", "--max_memory", "1G", "--SS_lib_type", "RF",
      "--left", "reads.left.fq.gz,reads2.left.fq.gz",
      "--right", "reads.right.fq.gz,reads2.right.fq.gz"
  end
end
