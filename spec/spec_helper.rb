require 'bundler/setup'
require 'litterbox'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def download_hab_plan
  domain = ENV['PLAN_DOMAIN'] || 'github.com'
  path = ENV['PLAN_PATH'] || '/habitat-sh/sample-node-app/archive/master.zip'
  download_path = "#{File.dirname(__FILE__)}/plan.zip"
  destination_path = "#{File.dirname(__FILE__)}/plan"

  puts `wget https://#{domain}#{path} -O #{download_path}`

  # require 'net/http'
  # Net::HTTP.start(domain) do |http|
  #   resp = http.get(path)
  #   open(download_path, 'wb') do |file|
  #     file.write(resp.body)
  #   end
  # end

  require 'zip'

  FileUtils.mkdir_p(destination_path)

  Zip::File.open(download_path) do |zip_file|
    zip_file.each do |f|
      fpath = File.join(destination_path, f.name)
      zip_file.extract(f, fpath) unless File.exist?(fpath)
    end
  end

  def cleanup_hab_plan
    download_path = "#{File.dirname(__FILE__)}/plan.zip"
    destination_path = "#{File.dirname(__FILE__)}/plan"
    puts `rm -rf #{download_path}`
    puts `rm -rf #{destination_path}`
  end
end
