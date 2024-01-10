# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class DeterminedAgent < Formula
  desc ""
  homepage "https://github.com/determined-ai/determined"
  version "0.27.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/determined-ai/determined/releases/download/0.27.0/determined-agent_0.27.0_darwin_arm64.tar.gz"
      sha256 "d748cadbbb11145c6d73cddf6cae0378fa8e3a9e9983171bfb7bd776978675f5"

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
      url "https://github.com/determined-ai/determined/releases/download/0.27.0/determined-agent_0.27.0_darwin_amd64.tar.gz"
      sha256 "a78e1e6fba718f997a8c93f160fad071b05c28d02c6e2ebfaf69d781d232eb21"

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
      url "https://github.com/determined-ai/determined/releases/download/0.27.0/determined-agent_0.27.0_linux_arm64.tar.gz"
      sha256 "659b6711efed775cb160b3bce65d87159d98c1cb02abd4220c685566e562468c"

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
      url "https://github.com/determined-ai/determined/releases/download/0.27.0/determined-agent_0.27.0_linux_amd64.tar.gz"
      sha256 "0f36578ccf310dddae1babcfcf35b15b55f3cf38032e9efbe77ea5f6e6fa49fb"

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
