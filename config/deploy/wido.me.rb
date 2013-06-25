set :deploy_to, "/var/www/wido.next/#{application}"

set :user, "www-data"
set :rails_env, :production
server "next.wido.me", :app, :web, :db, :primary => true , :whenever => true
# set :asset_env, "RAILS_RELATIVE_URL_ROOT=/mportal"
