RSpec.describe Litterbox do
  it 'has a version number' do
    expect(Litterbox::VERSION).not_to be nil
  end

  it 'parses a last_build.env file' do
    path = "#{File.dirname(__FILE__)}/last_build_test.env"
    last_build = Litterbox.last_build(path)
    expect(last_build)

    expect(last_build.pkg_origin).to eql 'skylerto'
    expect(last_build.pkg_name).to eql 'tests'
    expect(last_build.pkg_version).to eql '6.2.0'
    expect(last_build.pkg_release).to eql '20180222132339'
    expect(last_build.pkg_ident).to eql 'skylerto/tests/6.2.0/20180222132339'
    expect(last_build.pkg_artifact).to eql 'skylerto-tests-6.2.0-20180222132339-x86_64-linux.hart'
    expect(last_build.pkg_sha256sum).to eql '0fc503f9ebf5bde670176dd3eea6357a0ec9beb9738320cec8a4cdaa145f410b'
    expect(last_build.pkg_blake2bsum).to eql 'ec6909fa3eb5f80d50de2002a3baf038b75f9dfde6147974874a7f46336885b5'
  end

  it 'builds a habitat package' do
    download_hab_plan
    cleanup_hab_plan
  end
end
