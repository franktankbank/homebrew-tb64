class Tb64Cpp < Formula
  desc "A niche tool to encode text in base64 3 times. (C++ version)"
  homepage "https://github.com/franktankbank/tb64-cpp"
  url "https://github.com/franktankbank/tb64-cpp/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "e4f4e253bf153156ca0432ac657bfcc5e33b92cc648430167b6fb89807f1b76e"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "vcpkg" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
