class Tb64Cpp < Formula
  desc "A niche tool to encode text in base64 3 times. (C++ version)"
  homepage "https://github.com/franktankbank/tb64-cpp"
  url "https://github.com/franktankbank/tb64-cpp/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "4a9cf9ddbc6555714f1719a5f9af90e84e8f2ddb6324ce76928fd74baa58a9bf"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "mkdir", "#{buildpath}/vcpkg"
    
    cd "vcpkg" do
      system "git", "init"
      system "git", "remote", "add", "upstream", "https://github.com/microsoft/vcpkg.git"
      system "git", "pull", "upstream", "master"
      system "./bootstrap-vcpkg.sh", "-disableMetrics"
    end
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_TOOLCHAIN_FILE=#{buildpath}/vcpkg/scripts/buildsystems/vcpkg.cmake", "-DHOMEBREW=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
