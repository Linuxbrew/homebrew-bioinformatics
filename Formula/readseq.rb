class Readseq < Formula
  desc "Read and reformat biosequences"
  homepage "http://iubio.bio.indiana.edu/soft/molbio/readseq/java/"
  url "http://iubio.bio.indiana.edu/soft/molbio/readseq/java/readseq.jar"
  version "2.1.30"
  sha256 "830c79f5eba44c8862a30a03107fe65ad044b6b099b75f9638d7482e0375aab6"
  revision 1

  depends_on :java

  def install
    jar = "#{name}.jar"
    libexec.install jar
    bin.write_jar_script libexec/jar, name
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} -h 2>&1")
  end
end
