require 'open3'

module Litterbox
  module Habitat
    # Habitat package operations
    class Package
      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def exec(command)
        cmd = "hab pkg exec #{@name} #{command}"
        Open3.popen3(cmd) do |_, stdout, stderr, thr|
          while (line = stderr.gets)
            puts(line)
          end
          while (line = stdout.gets)
            puts(line)
          end
          return thr
        end
      end

      def upload(pkg, auth)
        Litterbox::Habitat::Upload.new(
          pkg, auth
        ).upload
      end
    end
  end
end
