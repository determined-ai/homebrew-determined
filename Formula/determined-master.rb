# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DeterminedMaster < Formula
  desc ""
  homepage "https://github.com/determined-ai/determined"
  version "0.35.0"
  license "Apache-2.0"

  depends_on "postgresql@14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/determined-ai/determined/releases/download/0.35.0/determined-master_0.35.0_darwin_arm64.tar.gz"
      sha256 "7029b33ce757391dd6058f96d883aecd5a9f516dd678860f43482c90c1dc7a8d"

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
      url "https://github.com/determined-ai/determined/releases/download/0.35.0/determined-master_0.35.0_darwin_amd64.tar.gz"
      sha256 "edb98c12abf22bace10e2f690ca7a19bd7ce757c4d3a0d9c873d98ae32ab1b09"

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
      url "https://github.com/determined-ai/determined/releases/download/0.35.0/determined-master_0.35.0_linux_arm64.tar.gz"
      sha256 "bca4cc6487165b15fd6ba923317e3ad025e445e6684af82bceaed6850db093f7"

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
      url "https://github.com/determined-ai/determined/releases/download/0.35.0/determined-master_0.35.0_linux_amd64.tar.gz"
      sha256 "45595f8d13d51cbd169f2e9a04331317896e3c6dc2dd29b8a23b523765d95646"

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
