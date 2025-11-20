class Tb64Cpp < Formula
  desc "A niche tool to encode text in base64 3 times. (C++ version)"
  homepage "https://github.com/franktankbank/tb64-cpp"
  url "https://github.com/franktankbank/tb64-cpp/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "19f4553feaf73e51345f67637dfcad025de88ab705891a5335c36a64e2ff1ced"
  license "GPL-3.0-only"

  depends_on "cmake" => :build
  depends_on "cpp-gsl" => :build

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
        system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_PREFIX=#{buildpath}/clip", "-DCLIP_ENABLE_IMAGE=OFF", "-DCLIP_EXAMPLES=OFF", "-DCLIP_TESTS=OFF", "-DCMAKE_BUILD_TYPE=Release"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end
    end

    resource("turbo-base64").stage do
      mkdir "build" do
        system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_PREFIX=#{buildpath}/turbo-base64", "-DCMAKE_BUILD_TYPE=Release"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end
    end

    system "cmake", "-S", ".", "-B", "build", "-DHOMEBREW=ON", "-DCMAKE_BUILD_TYPE=Release", "-DCLIP_ROOT=#{buildpath}/clip", "-DTURBO_BASE64_ROOT=#{buildpath}/turbo-base64", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
