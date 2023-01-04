# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DeterminedAgent < Formula
  desc ""
  homepage "https://github.com/determined-ai/determined"
  version "0.19.9-dev0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/determined-ai/determined/releases/download/0.19.9-dev0/determined-agent_0.19.9-dev0_darwin_arm64.tar.gz"
      sha256 "fd4305b58f2a3439b48149cee47e1a963c3e7789603a5066ebb90d1ca54e315f"

      def install
        bin.install "determined-agent"

        doc.install "LICENSE"

        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/agent.yaml" do |s|
          s.gsub! "# master_host: 0.0.0.0", "master_host: localhost"
          s.gsub! "# master_port: 80", "master_port: 8080"
        end

        Pathname("etc/determined/agent.yaml").append_lines <<~EOS
          container_master_host: host.docker.internal
        EOS

        etc.install "etc/determined/agent.yaml" => "determined/agent.yaml"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/determined-ai/determined/releases/download/0.19.9-dev0/determined-agent_0.19.9-dev0_darwin_amd64.tar.gz"
      sha256 "81b49bcd3c0184e7521f0fee95e943a52aa3c5a448ba5ae74cce33a13cb05ff1"

      def install
        bin.install "determined-agent"

        doc.install "LICENSE"

        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/agent.yaml" do |s|
          s.gsub! "# master_host: 0.0.0.0", "master_host: localhost"
          s.gsub! "# master_port: 80", "master_port: 8080"
        end

        Pathname("etc/determined/agent.yaml").append_lines <<~EOS
          container_master_host: host.docker.internal
        EOS

        etc.install "etc/determined/agent.yaml" => "determined/agent.yaml"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/determined-ai/determined/releases/download/0.19.9-dev0/determined-agent_0.19.9-dev0_linux_arm64.tar.gz"
      sha256 "98775940e6b86f73ed532b48dbf7c423f38c20db812a4e8a52debc9ec744a0a1"

      def install
        bin.install "determined-agent"

        doc.install "LICENSE"

        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/agent.yaml" do |s|
          s.gsub! "# master_host: 0.0.0.0", "master_host: localhost"
          s.gsub! "# master_port: 80", "master_port: 8080"
        end

        Pathname("etc/determined/agent.yaml").append_lines <<~EOS
          container_master_host: host.docker.internal
        EOS

        etc.install "etc/determined/agent.yaml" => "determined/agent.yaml"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/determined-ai/determined/releases/download/0.19.9-dev0/determined-agent_0.19.9-dev0_linux_amd64.tar.gz"
      sha256 "b85bb5f1ae87c22ffe8682fd41bc8b4287ca9085b505a706638f04176f08318a"

      def install
        bin.install "determined-agent"

        doc.install "LICENSE"

        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/agent.yaml" do |s|
          s.gsub! "# master_host: 0.0.0.0", "master_host: localhost"
          s.gsub! "# master_port: 80", "master_port: 8080"
        end

        Pathname("etc/determined/agent.yaml").append_lines <<~EOS
          container_master_host: host.docker.internal
        EOS

        etc.install "etc/determined/agent.yaml" => "determined/agent.yaml"
      end
    end
  end

  def caveats
    <<~EOS
      Determined agent config is located at #{etc}/determined/agent.yaml
    EOS
  end

  service do
    run [opt_bin/"determined-agent", "--config-file", etc/"determined/agent.yaml"]
    keep_alive false
    error_log_path var/"log/determined/agent-stderr.log"
    log_path var/"log/determined/agent-stdout.log"
  end
end
