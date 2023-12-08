# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DeterminedAgent < Formula
  desc ""
  homepage "https://github.com/determined-ai/determined"
  version "0.26.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/determined-ai/determined/releases/download/0.26.6/determined-agent_0.26.6_darwin_arm64.tar.gz"
      sha256 "6dfc35b48e1904edf89d45e0aac6c6584d35fa0af87b8bc1bca4ab238ce65c38"

      def install
        bin.install "determined-agent"

        doc.install "LICENSE"

        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/agent.yaml" do |s|
          s.gsub! "# master_host: 0.0.0.0", "master_host: 127.0.0.1"
          s.gsub! "# master_port: 80", "master_port: 8080"
        end

        Pathname("etc/determined/agent.yaml").append_lines <<~EOS
          container_master_host: host.docker.internal
        EOS

        etc.install "etc/determined/agent.yaml" => "determined/agent.yaml"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/determined-ai/determined/releases/download/0.26.6/determined-agent_0.26.6_darwin_amd64.tar.gz"
      sha256 "732f91d35c5d179a7eebf7bad85ba0637b1cb22fc6076082bc0180404ced2c54"

      def install
        bin.install "determined-agent"

        doc.install "LICENSE"

        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/agent.yaml" do |s|
          s.gsub! "# master_host: 0.0.0.0", "master_host: 127.0.0.1"
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
      url "https://github.com/determined-ai/determined/releases/download/0.26.6/determined-agent_0.26.6_linux_arm64.tar.gz"
      sha256 "5edd6604d7a68a1be9c2231c596f7c27659b57ccaecb293af7b7e78f6d70be4a"

      def install
        bin.install "determined-agent"

        doc.install "LICENSE"

        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/agent.yaml" do |s|
          s.gsub! "# master_host: 0.0.0.0", "master_host: 127.0.0.1"
          s.gsub! "# master_port: 80", "master_port: 8080"
        end

        Pathname("etc/determined/agent.yaml").append_lines <<~EOS
          container_master_host: host.docker.internal
        EOS

        etc.install "etc/determined/agent.yaml" => "determined/agent.yaml"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/determined-ai/determined/releases/download/0.26.6/determined-agent_0.26.6_linux_amd64.tar.gz"
      sha256 "9e0b322f7e2cfaae5a884f7f02523a40023c30855f337ac6cc77fa284c858567"

      def install
        bin.install "determined-agent"

        doc.install "LICENSE"

        (var/"log/determined").mkpath

        (etc/"determined").mkpath
        inreplace "etc/determined/agent.yaml" do |s|
          s.gsub! "# master_host: 0.0.0.0", "master_host: 127.0.0.1"
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
