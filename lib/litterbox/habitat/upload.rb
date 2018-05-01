require 'open3'

module Litterbox
  module Habitat
    # Habitat upload
    class Upload
      def initialize(pkg, auth)
        @pkg = pkg
        @auth = auth
      end

      def upload(pkg = @pkg, auth = @auth)
        raise 'file artifact not found' unless File.exist?(pkg)
        raise 'must pass auth token' unless auth
        cmd = "hab pkg upload #{pkg} -z #{auth}"
        puts cmd
        Open3.popen3(cmd) do |_, out, _, thr|
          while (line = out.gets)
            puts(line)
          end
          return thr.value
        end
      end
    end
  end
end
