set :rails_env, "production"
set :branch, "master"

#############################################################
#	Servers
#############################################################

role :app, "107.22.125.70"
role :web, "107.22.125.70"
role :db,  "107.22.125.70", :primary => true