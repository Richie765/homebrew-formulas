require 'formula'

class V83192 < Formula
  homepage 'http://code.google.com/p/v8/'
  # Use the official github mirror, it is easier to find tags there
  url 'https://github.com/v8/v8/archive/3.19.2.tar.gz'
  sha1 '0113996edc8a1102955b6c25d49e8add6602b0e1'

  keg_only 'Conflicts with V8 in main repository.'

  # gyp currently depends on a full xcode install
  # https://code.google.com/p/gyp/issues/detail?id=292
  depends_on :xcode

  def install
    system 'make dependencies'
    system 'make', 'native',
                   "-j#{ENV.make_jobs}",
                   "library=shared",
                   "snapshot=on",
                   "console=readline"

    prefix.install 'include'
    cd 'out/native' do
      lib.install Dir['lib*']
      bin.install 'd8', 'lineprocessor', 'preparser', 'process', 'shell' => 'v8'
      bin.install Dir['mksnapshot.*']
    end
  end
end
