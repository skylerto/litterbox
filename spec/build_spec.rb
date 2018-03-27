RSpec.describe Litterbox::Habitat::Build do
  it 'builds a habitat package' do
    download_hab_plan
    hab = Litterbox::Habitat::Build.new(plan_dir)
    hab.build
    last_build = Litterbox.last_build("#{plan_dir}/results/last_build.env")

    expect(last_build.pkg_origin).not_to be nil
    expect(last_build.pkg_name).not_to be nil
    expect(last_build.pkg_version).not_to be nil
    expect(last_build.pkg_release).not_to be nil
    expect(last_build.pkg_ident).not_to be nil
    expect(last_build.pkg_artifact).not_to be nil
    expect(last_build.pkg_sha256sum).not_to be nil
    expect(last_build.pkg_blake2bsum).not_to be nil
    cleanup_hab_plan
  end
end
