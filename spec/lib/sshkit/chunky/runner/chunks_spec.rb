require 'sshkit/chunky/runner/chunks'

describe SSHKit::Chunky::Runner::Chunks do
  describe '#group_size' do
    let(:options) { { count: 3 } }
    let(:block_to_run) { ->(host) { execute "echo #{Time.now.to_i}" } }
    let(:runner) do
      SSHKit::Chunky::Runner::Chunks.new(hosts, options, &block_to_run)
    end

    subject(:group_size) { runner.send(:group_size) }

    context 'with one host' do
      let(:hosts) { ['example.com'] }

      it 'returns one' do
        expect(group_size).to eq 1
      end
    end

    context 'with 6 hosts' do
      let(:hosts) { ['example.com'] * 6 }

      it 'returns 2' do
        expect(group_size).to eq 2
      end
    end

    context 'with 7 hosts' do
      let(:hosts) { ['example.com'] * 7 }

      it 'returns 3' do
        expect(group_size).to eq 3
      end
    end
  end
end
