class DshBio < Formula
  desc "Tools for BED, FASTA, FASTQ, GAF, GFA1/2, GFF3, PAF, SAM, and VCF files"
  homepage "https://github.com/heuermh/dishevelled-bio"
  url "https://search.maven.org/remotecontent?filepath=org/dishevelled/dsh-bio-tools/1.4/dsh-bio-tools-1.4-bin.tar.gz"
  sha256 "5ae307725cb3de630d45b656eccce0fc9ef2a33e57db42b184a371d578e7106c"
  license "LGPL-3.0-or-later"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "ecc8c494c76018044ed4744350e3008e2c3f4282b1111db48055a969c4b7a816" => :catalina
    sha256 "abe84532e871dee21be522bdd11b692f7ae162f8d7a7ee95770b8bc9701b1448" => :x86_64_linux
  end

  depends_on java: "1.8+"

  def install
    rm Dir["bin/*.bat"] # Remove all windows files
    libexec.install Dir["*"]
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/dsh-bio --help")
  end
end
