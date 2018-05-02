RSpec.describe Litterbox::Habitat::Package do
  it 'interacts with a habitat package' do
    package = Litterbox::Habitat::Package.new('core/gawk')
    out, err, thr = package.exec('gawk --version | grep "GNU Awk"')
    expect(out).to include('GNU Awk')
  end
end
