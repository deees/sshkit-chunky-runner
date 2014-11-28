require 'sshkit/chunky/runner/coordinator'

describe SSHKit::Coordinator do
  describe '#each' do
    let(:output) { '' }
    let(:block_to_run) { ->(host) { execute "echo #{Time.now.to_i}" } }

    subject(:results) do
      output.lines.map { |value| value.split(' ').last.to_i }
    end

    before do
      SSHKit.config.backend = SSHKit::Backend::Printer
    end

    context 'with default options' do
      before do
        SSHKit.capture_output output do
          SSHKit::Coordinator.new(%w{1.example.com 2.example.com})
            .each(&block_to_run)
        end
      end

      it 'returns parallel results' do
        expect(results.size).to eq 2
        expect(results.first).to eq results.last
      end
    end

    context 'with chunks options' do
      before do
        SSHKit.capture_output output do
          SSHKit::Coordinator.new(%w{1.example.com 2.example.com})
            .each(in: :chunks, count: 2, &block_to_run)
        end
      end

      it 'returns sequential results' do
        expect(results.size).to eq 2
        expect(results.first).to be < results.last
      end
    end
  end
end
