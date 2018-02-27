module Litterbox
  # LastBuild class
  class LastBuild
    attr_accessor :pkg_origin
    attr_accessor :pkg_name
    attr_accessor :pkg_version
    attr_accessor :pkg_release
    attr_accessor :pkg_ident
    attr_accessor :pkg_artifact
    attr_accessor :pkg_sha256sum
    attr_accessor :pkg_blake2bsum

    def self.parse(file)
      build = LastBuild.new
      File.readlines(file).each do |line|
        key, value = line.split('=')
        build.instance_variable_set("@#{key.strip}", value.strip)
      end
      build
    end
  end
end
