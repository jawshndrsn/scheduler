set :rails_env, "staging"
set :branch, "master"

#############################################################
#	Servers
#############################################################

role :app, "184.73.50.160"
role :web, "184.73.50.160"
role :db,  "184.73.50.160", :primary => true
