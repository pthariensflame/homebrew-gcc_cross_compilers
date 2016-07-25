require 'formula'

class X8664ElfGdb < Formula
  homepage "https://www.gnu.org/software/gdb/"
  url "http://ftpmirror.gnu.org/gdb/gdb-7.11.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gdb/gdb-7.11.tar.xz"
  sha256 "7a434116cb630d77bb40776e8f5d3937bed11dea56bafebb4d2bc5dd389fe5c1"

  depends_on 'x86_64-elf-binutils'
  depends_on 'x86_64-elf-gcc'

  def install
    ENV['CC'] = '/usr/local/opt/gcc/bin/gcc-6'
    ENV['CXX'] = '/usr/local/opt/gcc/bin/g++-6'
    ENV['CPP'] = '/usr/local/opt/gcc/bin/cpp-6'
    ENV['LD'] = '/usr/local/opt/gcc/bin/gcc-6'

    mkdir 'build' do
      system '../configure', '--target=x86_64-pc-linux', "--prefix=#{prefix}"
      system 'make'
      system 'make install'
      FileUtils.rm_rf share
    end
  end
end
