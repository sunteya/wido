require "capsum/typical"

set :application, "wido2"

set :shared, %w{
  config/database.yml
  config/settings.local.yml
}


# before 'deploy:assets:symlink' do

# end

before 'deploy:assets:precompile' do
  run <<-CMD.compact
    cd -- #{latest_release} && 
    #{rake} bower:install 
  CMD
end