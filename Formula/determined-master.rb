# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DeterminedMaster < Formula
  desc ""
  homepage "https://github.com/determined-ai/determined"
  version "0.28.0"
  license "Apache-2.0"

  depends_on "postgresql@14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/determined-ai/determined/releases/download/0.28.0/determined-master_0.28.0_darwin_arm64.tar.gz"
      sha256 "0bd0ba354cbcf7680ff337309e24f52c116b64d4e15b078b6642636667f369e6"

      def install
        bin.install "determined-master"

        doc.install "LICENSE"
        pkgshare.install Dir["share/*"]

        (var/"cache/determined").mkpath
        (var/"determined/data").mkpath
        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/master.yaml" do |s|
          s.gsub! "  host_path: /tmp", "  host_path: #{var}/determined/data"
        end
        Pathname("etc/determined/master.yaml").append_lines <<~EOS
          root: #{opt_pkgshare}
          cache:
            cache_dir: #{var}/cache/determined
        EOS
        etc.install "etc/determined/master.yaml" => "determined/master.yaml"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/determined-ai/determined/releases/download/0.28.0/determined-master_0.28.0_darwin_amd64.tar.gz"
      sha256 "80a16902978c911bfb06a3d4543247eb220373ffbe227f86f39dcf793aa02e3a"

      def install
        bin.install "determined-master"

        doc.install "LICENSE"
        pkgshare.install Dir["share/*"]

        (var/"cache/determined").mkpath
        (var/"determined/data").mkpath
        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/master.yaml" do |s|
          s.gsub! "  host_path: /tmp", "  host_path: #{var}/determined/data"
        end
        Pathname("etc/determined/master.yaml").append_lines <<~EOS
          root: #{opt_pkgshare}
          cache:
            cache_dir: #{var}/cache/determined
        EOS
        etc.install "etc/determined/master.yaml" => "determined/master.yaml"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/determined-ai/determined/releases/download/0.28.0/determined-master_0.28.0_linux_arm64.tar.gz"
      sha256 "8f28ad9c7da2325ad6a63c96e623033fd2d79e090b0d505d2c96f776059491d8"

      def install
        bin.install "determined-master"

        doc.install "LICENSE"
        pkgshare.install Dir["share/*"]

        (var/"cache/determined").mkpath
        (var/"determined/data").mkpath
        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/master.yaml" do |s|
          s.gsub! "  host_path: /tmp", "  host_path: #{var}/determined/data"
        end
        Pathname("etc/determined/master.yaml").append_lines <<~EOS
          root: #{opt_pkgshare}
          cache:
            cache_dir: #{var}/cache/determined
        EOS
        etc.install "etc/determined/master.yaml" => "determined/master.yaml"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/determined-ai/determined/releases/download/0.28.0/determined-master_0.28.0_linux_amd64.tar.gz"
      sha256 "b32dac758e99a891ea19be957f10d0bcb99f5f0864d3e07c6fbff286e21c0234"

      def install
        bin.install "determined-master"

        doc.install "LICENSE"
        pkgshare.install Dir["share/*"]

        (var/"cache/determined").mkpath
        (var/"determined/data").mkpath
        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/master.yaml" do |s|
          s.gsub! "  host_path: /tmp", "  host_path: #{var}/determined/data"
        end
        Pathname("etc/determined/master.yaml").append_lines <<~EOS
          root: #{opt_pkgshare}
          cache:
            cache_dir: #{var}/cache/determined
        EOS
        etc.install "etc/determined/master.yaml" => "determined/master.yaml"
      end
    end
  end

  def caveats
    <<~EOS
      Determined master config is located at #{etc}/determined/master.yaml

      Make sure to setup the determined database:
        brew services start postgresql@14
        createuser postgres
        createdb determined

      Checkpoints are stored in #{var}/determined/data by default.
      Make sure to configure it as a shared path for Docker for Mac in
      Docker -> Preferences... -> Resources -> File Sharing.
    EOS
  end

  service do
    run [opt_bin/"determined-master", "--config-file", etc/"determined/master.yaml"]
    keep_alive false
    error_log_path var/"log/determined/master-stderr.log"
    log_path var/"log/determined/master-stdout.log"
  end
end
