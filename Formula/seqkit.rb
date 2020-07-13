class Seqkit < Formula
  # cite Shen_2016: "https://doi.org/10.1371/journal.pone.0163962"
  desc "Ultrafast FASTA/Q file manipulation"
  homepage "https://bioinf.shenwei.me/seqkit/"
  # We use binaries to avoid compiling Go code
  if OS.mac?
    url "https://github.com/shenwei356/seqkit/releases/download/v0.13.2/seqkit_darwin_amd64.tar.gz"
    sha256 "1c5c4f5224e1c584ed944dc0d4da879124bb267c2f0805a1f623f4fe1920c744"
  else
    url "https://github.com/shenwei356/seqkit/releases/download/v0.13.2/seqkit_linux_amd64.tar.gz"
    sha256 "53703542d44a5e758eaf34b55d18f70cfe23e9b5b78fd7c1c0202dee9a65bed0"
  end
  version "0.13.2"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "7a5805209ae2a70e39efa71125ac23215a6f5a56f240213483071a0d31adaa93" => :catalina
    sha256 "6cd3a52182fef2036cabb50dee045e258d1b5b392ff689c1b257315b4e82223b" => :x86_64_linux
  end

  def install
    bin.install "seqkit"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/seqkit version")
  end
end
