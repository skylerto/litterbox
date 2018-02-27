RSpec.describe Litterbox do
  it 'has a version number' do
    expect(Litterbox::VERSION).not_to be nil
  end

  it 'parses a last_build' do
    path = "#{File.dirname(__FILE__)}/last_build_test.env"
    last_build = Litterbox.last_build(path)
  end
end
