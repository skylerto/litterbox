RSpec.describe Litterbox::Habitat::Package do
  it 'interacts with a habitat package' do
    package = Litterbox::Habitat::Package.new('core/gawk')
    cmd = package.exec('gawk --version | grep "GNU Awk"')
    expect(cmd.stdout).to include('GNU Awk')
  end
end
