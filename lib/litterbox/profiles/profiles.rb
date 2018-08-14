require 'toml'

module Litterbox
  module Habitat
    # Habitat Profile
    class Profiles
      def self.set(profile, file = "#{ENV['HOME']}/.litterbox")
        config = read file
        config['profile'] = profile
        doc = TOML::Generator.new(config).body
        File.write(file, doc)
        env config[profile]
      end

      def self.read(config = "#{ENV['HOME']}/.litterbox")
        unless File.exist?(config)
          # Create it
        end
        TOML::Parser.new(File.read(config)).parsed
      end

      def self.env(profile)
        cmd = ''
        cmd << "export HAB_BLDR_URL=\"#{profile['bldr_url']}\"\n" if profile['bldr_url']
        cmd << "export HAB_AUTH_TOKEN=\"#{profile['auth_token']}\"\n" if profile['auth_token']
        cmd << "export HAB_ORIGIN=\"#{profile['origin']}\"\n" if profile['origin']
        cmd
      end
    end
  end
end
