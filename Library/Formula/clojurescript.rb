require 'formula'

class Clojurescript < Formula
  homepage 'https://github.com/clojure/clojurescript'
  head 'https://github.com/clojure/clojurescript.git'
  url 'https://github.com/clojure/clojurescript/archive/r2138.tar.gz'
  sha1 'd67c77e5da59cc316300ff78a40e7fe3aa8d56fe'

  def install
    system "./script/bootstrap"
    inreplace %w(bin/cljsc script/repl script/repljs script/browser-repl),
      "#!/bin/sh", "#!/bin/sh\nCLOJURESCRIPT_HOME=#{libexec}"
    libexec.install Dir['*']
    bin.write_exec_script libexec/'bin/cljsc'
  end

  def caveats; <<-EOS.undent
    This formula is useful if you need to use the ClojureScript compiler directly.
    For a more integrated workflow, Leiningen with lein-cljsbuild is recommended.
    EOS
  end

  test do
    system "#{bin}/cljsc"
  end
end
