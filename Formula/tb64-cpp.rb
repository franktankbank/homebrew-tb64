class Tb64Cpp < Formula
  desc "A niche tool to encode text in base64 3 times. (C++ version)"
  homepage "https://github.com/franktankbank/tb64-cpp"
  url "https://github.com/franktankbank/tb64-cpp/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "4a9cf9ddbc6555714f1719a5f9af90e84e8f2ddb6324ce76928fd74baa58a9bf"
  license "MIT"

  depends_on "cmake" => :build
  # depends_on "cpp-gsl" => :build

  resource "vcpkg" do
    url "https://github.com/microsoft/vcpkg/archive/refs/tags/2025.08.27.tar.gz"
    sha256 "b7ca5a754e4fbaa0f1d36c5f19ceef4ed47c65312fed298bb3dcf73c276dbe9b"
  end

  def install
    resource("vcpkg").stage buildpath/"vcpkg"
    
    cd "vcpkg" do
      system "./bootstrap-vcpkg.sh", "-disableMetrics"
      system "git", "status"
    end
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_TOOLCHAIN_FILE=#{buildpath}/vcpkg/scripts/buildsystems/vcpkg.cmake", "-DHOMEBREW=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
