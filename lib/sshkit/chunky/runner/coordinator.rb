require 'sshkit/coordinator'

module SSHKit
  class Coordinator
    # overrides original method to include chunks runner
    def each(options={}, &block)
      if hosts
        options = default_options.merge(options)
        case options[:in]
        when :parallel then Runner::Parallel
        when :sequence then Runner::Sequential
        when :groups   then Runner::Group
        when :chunks   then SSHKit::Chunky::Runner::Chunks # <- added
        else
          options[:in]
        end.new(hosts, options, &block).execute
      else
        Runner::Null.new(hosts, options, &block).execute
      end
    end
  end
end
