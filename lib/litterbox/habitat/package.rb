module Litterbox
  module Habitat
    # Habitat package operations
    class Package
      attr_accessor :name

      def initialize(name)
        @name = name
      end

      def install(name = @name)
        Litterbox::Command.exec(
          "hab pkg install #{name}"
        )
      end

      def exec(command)
        install
        Litterbox::Command.exec(
          "hab pkg exec #{@name} #{command}"
        )
      end

      def upload(pkg, auth)
        Litterbox::Habitat::Upload.new(
          pkg, auth
        ).upload
      end
    end
  end
end
