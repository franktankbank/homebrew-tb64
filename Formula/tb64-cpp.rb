class Tb64Cpp < Formula
  desc "A niche tool to encode text in base64 3 times. (C++ version)"
  homepage "https://github.com/franktankbank/tb64-cpp"
  url "https://github.com/franktankbank/tb64-cpp/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "92ac15d69233697d79e6e38301c5659d4d1c22b4e5d73526e7f45972e022525e"
  license "GPL-3.0-only"

  depends_on "cmake" => :build
  depends_on "cpp-gsl" => :build
  depends_on "cli11" => :build

  resource "clip" do
    url "https://github.com/dacap/clip/archive/refs/tags/v1.12.tar.gz"
    sha256 "54e96e04115c7ca1eeeecf432548db5cd3dddb08a91ededb118adc31b128e08c"
  end

  resource "turbo-base64" do
    url "https://github.com/franktankbank/Turbo-Base64/archive/refs/heads/master.zip"
    sha256 "49e66127b451c44a18bfd5d1c9f5ed79506c08c04db41338fc7926736e28396e"
  end

  def install
    resource("clip").stage do
      mkdir "build" do
        system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_PREFIX=#{buildpath}/clip", "-DCLIP_ENABLE_IMAGE=OFF", "-DCLIP_EXAMPLES=OFF", "-DCLIP_TESTS=OFF", "-DCLIP_INSTALL=ON", "-DCMAKE_BUILD_TYPE=Release"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end
    end

    resource("turbo-base64").stage do
      mkdir "build" do
        system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_PREFIX=#{buildpath}/turbo-base64", "-DCMAKE_BUILD_TYPE=Release", "-DBUILD_APP=OFF", "-DBUILD_SHARED_LIBS=OFF", "-DFULLCHECK=OFF", "-DNAVX512=OFF", "-DNCHECK=OFF"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end
    end

    system "cmake", "-S", ".", "-B", "build", "-DHOMEBREW=ON", "-DCMAKE_BUILD_TYPE=Release", "-DCLIP_ROOT=#{buildpath}/clip", "-DTURBO_BASE64_ROOT=#{buildpath}/turbo-base64", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
