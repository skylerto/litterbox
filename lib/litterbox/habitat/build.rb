require 'open3'

module Litterbox
  module Habitat
    # Habitat build
    class Build
      def initialize(dir)
        @dir = dir
      end

      def build(dir = '.')
        Open3.popen3("cd #{@dir} && hab pkg build #{dir}") do |_, stderr, _, _|
          while (line = stderr.gets)
            puts(line)
          end
        end
      end
    end
  end
end
