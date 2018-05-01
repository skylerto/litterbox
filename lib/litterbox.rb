require 'thor'

require 'litterbox/habitat'
require 'litterbox/last_build'
require 'litterbox/version'

# Top level module for Litterbox
module Litterbox
  # Constant to define the name of the last_build file
  LAST_BUILD = 'last_build.env'.freeze

  # CLI for litterbox
  class CLI < Thor
    desc 'build PATH', 'build a package at the given path defaults to .'
    def build(path = '.')
      Litterbox::Habitat::Build.new(path).build
    end

    desc 'upload PATH', 'upload the latest build'
    def upload(path = find_last_build)
      raise "Could not find last_build.env in #{locations}" unless path
      path = File.join(path, LAST_BUILD) unless path.include?(LAST_BUILD)
      last_build = Litterbox.last_build(
        path
      )
      plan_dir = path.dup
      plan_dir.slice! LAST_BUILD
      artifact = File.join(plan_dir, last_build.pkg_artifact)
      Litterbox::Habitat::Upload.new(
        artifact,
        ENV['HAB_AUTH_TOKEN']
      ).upload
    end

    desc 'export EXPORTER', 'export a package via exporter'
    def export(exporter = 'docker')
      path ||= find_last_build
      raise "Could not find last_build.env in #{locations}" unless path

      path = File.join(LAST_BUILD) unless path.include?(LAST_BUILD)
      last_build = Litterbox.last_build(
        path
      )

      Litterbox::Habitat::Export.new(
        File.join(plan_dir, 'results', last_build.pkg_artifact),
        exporter
      ).upload
    end

    private

    def find_last_build
      locations = [
        File.join('.', 'results'),
        File.join('habitat', 'results')
      ]
      exists = {}
      locations.each do |loc|
        return loc if File.exist?(File.join(loc, LAST_BUILD))
      end
    end
  end

  class << self
    def last_build(path)
      Litterbox::LastBuild.parse(path)
    end
  end
end
