module Litterbox
  # CLI Command operations
  module Command
    class << self
      def exec(cmd)
        out, err = ''
        cmd = "sudo #{cmd}" if ENV['USE_SUDO']
        Open3.popen3(cmd) do |_, stdout, stderr, thr|
          while (line = stderr.gets)
            err << line
            puts(line)
          end
          while (line = stdout.gets)
            out << line
            puts(line)
          end
          return out, err, thr
        end
      end
    end
  end
end
