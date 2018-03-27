require 'open3'

module Litterbox
  module Habitat
    # Habitat upload
    class Promote
      def initialize(pkg_ident, channel, auth)
        @pkg_ident = pkg_ident
        @channel = channel
        @auth = auth
      end

      def promote(pkg_ident = @pkg_ident, channel = @channel, auth = @auth)
        command = "hab pkg promote #{pkg_ident} #{channel} -z #{auth}"
        Open3.popen3(command) do |_, out, _, thr|
          while (line = out.gets)
            puts(line)
          end
          return thr.value
        end
      end
    end
  end
end
