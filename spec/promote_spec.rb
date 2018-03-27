RSpec.describe Litterbox::Habitat::Promote do
  it 'promotes a habitat package' do
    download_hab_plan
    hab = Litterbox::Habitat::Build.new(plan_dir)
    hab.build
    last_build = Litterbox.last_build("#{plan_dir}/results/last_build.env")

    hab = Litterbox::Habitat::Upload.new(
      File.join(plan_dir, 'results', last_build.pkg_artifact),
      ENV['HAB_AUTH_TOKEN']
    )

    expect(hab.upload.exitstatus).to eq 0

    channel = 'stable'
    hab = Litterbox::Habitat::Promote.new(
      last_build.pkg_ident,
      channel,
      ENV['HAB_AUTH_TOKEN']
    )

    expect(hab.promote.exitstatus).to eq 0

    cleanup_hab_plan
  end
end
