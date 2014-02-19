require "capsum/typical"

set :application, "wido2"
set :bundle_dir, -> { File.join(shared_path, 'bundle') }

set :shared, %w{
  config/database.yml
  config/settings.local.yml
}
