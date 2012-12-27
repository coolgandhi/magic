set :application, "magicdelivery"
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/freeinstanceTrip.pem"]
#ssh_options[:forward_agent] = true
set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :repository, "git@github.com:coolgandhi/magic.git"
set :deploy_to, "/var/www/magicdelivery"
#set :deploy_subdir, "magicdelivery"
set :deploy_via, :copy
set :git_shallow_clone, 1
set :branch, "master"
set :user, "ec2-user"
set :scm_username, "coolgandhi"
set :scm_command, "/usr/local/git/bin/git"
set :local_scm_command, "git" 

set :location, "ec2-50-112-211-203.us-west-2.compute.amazonaws.com"
role :web, location                       # Your HTTP server, Apache/etc
role :app, location                          # This may be the same as your `Web` server
role :db,  location, :primary => true # This is where Rails migrations will run
role :db,  location

set :rails_env, "production"
set :normalize_asset_timestamps, false

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts


set :ec2onrails_config, {
	:mysql_root_password => "QAZwsx987"
}

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end
