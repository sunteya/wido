set :deploy_to, "/var/www/wido/apps/#{application}"

set :user, "www-data"
set :rails_env, :production
server "wido.me", :app, :web, :db, :primary => true , :whenever => true
