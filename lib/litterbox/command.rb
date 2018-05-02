module Litterbox
  # CLI Command operations
  class Command
    attr_accessor :stdout, :stderr, :process
    def initialize(cmd, log = ENV['LITTERBOX_LOG'])
      @cmd = cmd
      @cmd = "sudo #{@cmd}" if ENV['USE_SUDO']
      @stdout = ''
      @stderr = ''
      @log = log
    end

    def run_command
      Open3.popen3(@cmd) do |_, out, err, thr|
        while (line = err.gets)
          @stderr << line unless line.nil?
          puts(line) if @log
        end
        while (lines = out.gets)
          @stdout << lines unless lines.nil?
          puts(lines) if @log
        end
        @process = thr.value
        return @stdout, @stderr, @process
      end
    end
  end
end
