class Tb64Cpp < Formula
  desc "A niche tool to encode text in base64 3 times. (C++ version)"
  homepage "https://github.com/franktankbank/tb64-cpp"
  url "https://github.com/franktankbank/tb64-cpp/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "fd951706e838925c3ca5c92443b5331dc81fc88fc135632de85df45608b7253a"
  license "MIT"

  depends_on "cmake" => :build

  resource "clip" do
    url "https://github.com/dacap/clip/archive/refs/tags/v1.10.tar.gz"
    sha256 "6b27976f0d1940697338f374a879964fff8fc02d0263faa76cfab99c9afff86f"
  end

  def install
    system "mkdir", "#{buildpath}/vcpkg"

    resource("clip").stage do
      mkdir "build" do
        system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_PREFIX=#{buildpath}/clip", "-DCLIP_ENABLE_IMAGE=OFF", "-DCLIP_EXAMPLES=OFF", "-DCLIP_TESTS=OFF", "-DCMAKE_BUILD_TYPE=Release"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end
    end
    
    cd "vcpkg" do
      system "git", "init"
      system "git", "remote", "add", "upstream", "https://github.com/microsoft/vcpkg.git"
      system "git", "pull", "upstream", "master"
      system "./bootstrap-vcpkg.sh", "-disableMetrics"
    end
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_TOOLCHAIN_FILE=#{buildpath}/vcpkg/scripts/buildsystems/vcpkg.cmake", "-DHOMEBREW=ON", "-DCMAKE_BUILD_TYPE=Release", "-DCLIP_ROOT=#{buildpath}/clip", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
