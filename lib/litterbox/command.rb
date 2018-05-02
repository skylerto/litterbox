module Litterbox
  # CLI Command operations
  module Command
    class << self
      def exec(cmd)
        out, err = ''
        cmd = "sudo #{cmd}" if ENV['USE_SUDO']
        Open3.popen3(cmd) do |_, stdout, stderr, thr|
          while (line = stderr.gets)
            err << line unless line.nil?
            puts(line)
          end
          while (lines = stdout.gets)
            out << lines unless lines.nil?
            puts(lines)
          end
          return out, err, thr
        end
      end
    end
  end
end
