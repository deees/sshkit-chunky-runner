module SSHKit
  module Chunky
    module Runner
      class Chunks < SSHKit::Runner::Sequential
        attr_writer :chunks_count

        def execute
          each_chunk(hosts).map do |group_hosts|
            SSHKit::Runner::Parallel.new(group_hosts, &block).execute
            sleep wait_interval
          end.flatten
        end

        private

        def each_chunk(array)
          return array.map { |item| [item] } if array.size <= chunks_count

          division = array.size.div chunks_count
          modulo = array.size % chunks_count

          groups = []
          start = 0

          chunks_count.times do |index|
            length = division + (modulo > 0 && modulo > index ? 1 : 0)
            groups << array.slice(start, length)
            start += length
          end

          groups
        end

        def chunks_count
          @chunks_count || options[:count] || 2
        end
      end
    end
  end
end
