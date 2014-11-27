module SSHKit
  module Chunky
    module Runner
      class Chunks < SSHKit::Runner::Group
        attr_writer :chunks_count

        private

        def group_size
          (hosts.size.to_f / chunks_count).ceil
        end

        def chunks_count
          @chunks_count || options[:count] || 2
        end
      end
    end
  end
end
