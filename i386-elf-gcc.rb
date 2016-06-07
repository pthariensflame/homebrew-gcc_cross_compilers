require 'formula'

class I386ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/gcc/gcc-5.2.0/gcc-5.2.0.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-5.2.0/gcc-5.2.0.tar.gz'
  sha1 '713211883406b3839bdba4a22e7111a0cff5d09b'

  # depends_on 'gmp'
  # depends_on 'libmpc'
  # depends_on 'mpfr'
  depends_on 'i386-elf-binutils'
  depends_on 'wget'

  def install
    binutils = Formula.factory 'i386-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-6'
    ENV['CXX'] = '/usr/local/bin/g++-6'
    ENV['CPP'] = '/usr/local/bin/cpp-6'
    ENV['LD'] = '/usr/local/bin/gcc-6'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system 'cd .. && ./contrib/download_prerequisites && cd build'
      system '../configure', '--disable-nls', '--target=i386-elf', '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers",
                             "--without-isl"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i386-elf", prefix/"i386-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
