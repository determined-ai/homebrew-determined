# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DeterminedMaster < Formula
  desc ""
  homepage "https://github.com/determined-ai/determined"
  version "0.27.0"
  license "Apache-2.0"

  depends_on "postgresql@14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/determined-ai/determined/releases/download/0.27.0/determined-master_0.27.0_darwin_arm64.tar.gz"
      sha256 "dc9bfbe4d1a1de2d2ae0f6c663dd1dc5954fa9e4ace5d4dfd41cb2bf975de74f"

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
      url "https://github.com/determined-ai/determined/releases/download/0.27.0/determined-master_0.27.0_darwin_amd64.tar.gz"
      sha256 "841d3dc9aaf8421497b748a33c11d20c2d47e8ba4fc54c52e761077cef73b178"

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
      url "https://github.com/determined-ai/determined/releases/download/0.27.0/determined-master_0.27.0_linux_arm64.tar.gz"
      sha256 "42784b1c38470014ae70f60a7f3ec14fb72acf32980700d0e96a5929f5274a8b"

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
      url "https://github.com/determined-ai/determined/releases/download/0.27.0/determined-master_0.27.0_linux_amd64.tar.gz"
      sha256 "beadf23b751cace5613999efeace51dbaabce369daff47a3a83e4ef6d1e420d1"

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
