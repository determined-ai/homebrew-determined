# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DeterminedMaster < Formula
  desc ""
  homepage "https://github.com/determined-ai/determined"
  version "0.19.9-dev0"
  license "Apache-2.0"

  depends_on "postgresql@14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/determined-ai/determined/releases/download/0.19.9-dev0/determined-master_0.19.9-dev0_darwin_arm64.tar.gz"
      sha256 "f814bf03b060b245dbf25babb72c4da601ecb98dd62e24928947f23b86b26452"

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
          root: #{pkgshare}
          cache:
            cache_dir: #{var}/cache/determined
        EOS
        etc.install "etc/determined/master.yaml" => "determined/master.yaml"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/determined-ai/determined/releases/download/0.19.9-dev0/determined-master_0.19.9-dev0_darwin_amd64.tar.gz"
      sha256 "3e4ff4ed39691a973d7989a15406f045c098bb2832a45c6166144cd3e5e7c6c8"

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
          root: #{pkgshare}
          cache:
            cache_dir: #{var}/cache/determined
        EOS
        etc.install "etc/determined/master.yaml" => "determined/master.yaml"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/determined-ai/determined/releases/download/0.19.9-dev0/determined-master_0.19.9-dev0_linux_arm64.tar.gz"
      sha256 "e1d0ede74b6b083ebb138e2186ab7500a7c7aa7a5048a676fe29ee4897a3958a"

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
          root: #{pkgshare}
          cache:
            cache_dir: #{var}/cache/determined
        EOS
        etc.install "etc/determined/master.yaml" => "determined/master.yaml"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/determined-ai/determined/releases/download/0.19.9-dev0/determined-master_0.19.9-dev0_linux_amd64.tar.gz"
      sha256 "72f7a4dd47acb0fce84def11d343199776d49e6c291de17813accda3b0317dcd"

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
          root: #{pkgshare}
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
    EOS
  end

  service do
    run [opt_bin/"determined-master", "--config-file", etc/"determined/master.yaml"]
    keep_alive false
    error_log_path var/"log/determined/master-stderr.log"
    log_path var/"log/determined/master-stdout.log"
  end
end
