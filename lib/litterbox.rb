require 'litterbox/version'
require 'litterbox/last_build'

# Top level module for Litterbox
module Litterbox
  class << self
    def last_build(path)
      Litterbox::LastBuild.parse(path)
    end
  end
end
