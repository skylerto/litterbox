RSpec.describe Litterbox::Habitat::Build do
  it 'builds a habitat package' do
    download_hab_plan
    hab = Litterbox::Habitat::Build.new(plan_dir)
    hab.build
    last_build = Litterbox.last_build("#{plan_dir}/results/last_build.env")

    puts File.join(plan_dir, 'results', last_build.pkg_artifact)

    hab = Litterbox::Habitat::Upload.new(
      File.join(plan_dir, 'results', last_build.pkg_artifact),
      ENV['HAB_AUTH_TOKEN']
    )

    hab.upload
    cleanup_hab_plan
  end
end
