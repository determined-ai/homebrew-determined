# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DeterminedMaster < Formula
  desc ""
  homepage "https://github.com/determined-ai/determined"
  version "0.34.0"
  license "Apache-2.0"

  depends_on "postgresql@14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/determined-ai/determined/releases/download/0.34.0/determined-master_0.34.0_darwin_arm64.tar.gz"
      sha256 "5fefc3004568f3b48d2598cd485ebf1f422384cab4ea525326f7219ad52b9c01"

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
      url "https://github.com/determined-ai/determined/releases/download/0.34.0/determined-master_0.34.0_darwin_amd64.tar.gz"
      sha256 "b607732e5675ed0608a6d0217dbc9c8a9318504d5b5f815f30171e9b63035fee"

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
      url "https://github.com/determined-ai/determined/releases/download/0.34.0/determined-master_0.34.0_linux_arm64.tar.gz"
      sha256 "7d09fac8dff7e6104b11d09c3817c658fe7021da5cd2886f7662bd61cef24f4e"

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
      url "https://github.com/determined-ai/determined/releases/download/0.34.0/determined-master_0.34.0_linux_amd64.tar.gz"
      sha256 "478366d1e45198a0cb1281310b4cab945c91003bb96180fd282dd6061fbb0262"

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
