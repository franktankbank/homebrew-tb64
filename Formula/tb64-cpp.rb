class Tb64Cpp < Formula
  desc "A niche tool to encode text in base64 3 times. (C++ version)"
  homepage "https://github.com/franktankbank/tb64-cpp"
  url "https://github.com/franktankbank/tb64-cpp/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "1c356bc1e5cfc7106f18713d98250af17e7b04abb36f527afb0471f32c8066ca"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "vcpkg" => :build

  def install
    vcpkg_root = ENV["VCPKG_ROOT"]
    system "cmake", "-S", ".", "-B", "build", "-DVCPKG_ROOT=#{vcpkg_root}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
