RSpec.describe Litterbox::Habitat::Package do
  it 'interacts with a habitat package' do
    package = Litterbox::Habitat::Package.new('core/curl')
    res = package.exec('curl -s -o /dev/null -w "%{http_code}" http://google.ca')
    expect(res).to eq '200'
  end
end
