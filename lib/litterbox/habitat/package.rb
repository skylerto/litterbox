module Litterbox
  module Habitat
    # Habitat package operations
    class Package
      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def install(name = @name)
        exec_cmd "hab pkg install #{name}"
      end

      def exec(command)
        install
        exec_cmd "hab pkg exec #{@name} #{command}"
      end

      def upload(pkg, auth)
        Litterbox::Habitat::Upload.new(
          pkg, auth
        ).upload
      end

      def promote(pkg_ident, channel, auth = ENV['HAB_AUTH_TOKEN'])
        Litterbox::Habitat::Promote.new(
          pkg_ident, channel, auth
        ).promote
      end

      def demote(pkg_ident, channel, auth = ENV['HAB_AUTH_TOKEN'])
        exec_cmd "hab pkg demote #{pkg_ident} #{channel} -z #{auth}"
      end

      private

      def exec_cmd(command)
        cmd = Litterbox::Command.new(
          command
        )
        cmd.run_command
        cmd
      end
    end
  end
end
