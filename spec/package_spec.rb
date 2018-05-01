RSpec.describe Litterbox::Habitat::Package do
  it 'interacts with a habitat package' do
    package = Litterbox::Habitat::Package.new('core/gawk')
    res = package.exec('gawk --version | grep "GNU Awk"')
    expect(res).to include('GNU Awk')
  end
end
