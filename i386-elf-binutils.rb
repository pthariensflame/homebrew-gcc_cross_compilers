require 'formula'

class I386ElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.gz'
  sha1 'f10c64e92d9c72ee428df3feaf349c4ecb2493bd'

  # depends_on 'apple-gcc42' => :build

  def install
    ENV['CC'] = '/usr/local/bin/gcc-5'
    ENV['CXX'] = '/usr/local/bin/g++-5'
    ENV['CPP'] = '/usr/local/bin/cpp-5'
    ENV['LD'] = '/usr/local/bin/gcc-5'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-elf',
                             '--disable-werror', 
                             '--enable-gold=yes',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end
