class Tb64Cpp < Formula
  desc "A niche tool to encode text in base64 3 times. (C++ version)"
  homepage "https://github.com/franktankbank/tb64-cpp"
  url "https://github.com/franktankbank/tb64-cpp/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "59211213f318047475012db164a51d48865c320d0489ecf173794419635e3b04"
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

  resource "cli11" do
    url "https://github.com/CLIUtils/CLI11/archive/refs/tags/v2.6.1.tar.gz"
    sha256 "377691f3fac2b340f12a2f79f523c780564578ba3d6eaf5238e9f35895d5ba95"
  end

  def install
    resource("clip").stage do
      mkdir "build" do
        system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_PREFIX=#{buildpath}/clip", "-DCLIP_ENABLE_IMAGE=OFF", "-DCLIP_EXAMPLES=OFF", "-DCLIP_TESTS=OFF", "-DCLIP_INSTALL=OFF", "-DCMAKE_BUILD_TYPE=Release"
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

    resource("cli11").stage do
      mkdir "build" do
        system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_PREFIX=#{buildpath}/cli11", "-DCMAKE_BUILD_TYPE=Release", "-DBUILD_TESTING=OFF", "-DCLI11_BOOST=OFF", "-DCLI11_BUILD_EXAMPLES=OFF", "-DCLI11_BUILD_EXAMPLES_JSON=OFF", "-DCLI11_BUILD_TESTS=OFF", "-DCLI11_CUDA_TESTS=OFF", "-DCLI11_INSTALL=OFF", "-DCLI11_PRECOMPILED=ON", "-DCLI11_SANITIZERS=OFF", "-DCLI11_SINGLE_FILE=OFF", "-DCLI11_WARNINGS_AS_ERRORS=OFF"
        system "cmake", "--build", "."
        system "cmake", "--install", "."
      end
    end

    system "cmake", "-S", ".", "-B", "build", "-DHOMEBREW=ON", "-DCMAKE_BUILD_TYPE=Release", "-DCLIP_ROOT=#{buildpath}/clip", "-DTURBO_BASE64_ROOT=#{buildpath}/turbo-base64", "-DCLI11_ROOT=#{buildpath}/cli11", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
