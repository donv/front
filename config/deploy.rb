set :application, "front"
set :repository, "svn+ssh://donv@source.kubosch.no/var/svn/trunk/#{application}"

#role :web, "www.kubosch.no"
role :app, "www.kubosch.no"
role :db,  "www.kubosch.no", :primary => true

# set :deploy_to, "/path/to/app" # defaults to "/u/apps/#{application}"
set :user, "root"                # defaults to the currently logged in user
set :use_sudo, false

desc "The spinner task is used by :cold_deploy to start the application up"
task :spinner, :roles => :app do
send(run_method, "/sbin/service #{application} start")
end

desc "Restart the mongrel server"
task :restart, :roles => :app do
send(run_method, "/sbin/service #{application} restart")
end
