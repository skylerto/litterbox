require 'open3'

module Litterbox
  module Habitat
    # Habitat upload
    class Export
      def initialize(pkg, exporter = 'docker')
        @pkg = pkg
        @exporter = exporter
      end

      def upload(pkg = @pkg, exporter = @exporter)
        raise 'file artifact not found' unless File.exist?(pkg)
        Open3.popen3("hab pkg export #{exporter} #{pkg}") do |_, out, _, thr|
          while (line = out.gets)
            puts(line)
          end
          return thr.value
        end
      end
    end
  end
end
