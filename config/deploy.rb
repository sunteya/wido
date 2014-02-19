require "capsum/typical"

set :application, "wido2"

set :shared, %w{
  config/database.yml
  config/settings.local.yml
}
