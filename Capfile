load 'deploy' if respond_to?(:namespace) # cap2 differentiator
default_run_options[:pty] = true

# be sure to change these
set :user, 'user'
set :domain, 'deploy_site'
set :application_location, 'deploy_location'

# the rest should be good
set :repository,  "git://github.com/h-lame/one_stop_shop.git" 
set :deploy_to, "/home/#{user}/#{application_location}" 
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

server domain, :app, :web

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end

# If you're not deploying to dreamhost, or they've upgraded their rack version
# you don't need this

after 'deploy:setup',       'vendor_gems:unpack'
after 'deploy:update_code', 'vendor_gems:symlink'
after 'deploy:update_code', 'vendor_gems:mess_with_config_ru'

namespace :vendor_gems do
  task :unpack do
    run "cd #{shared_path}/system && gem unpack rack && mv rack-* rack"
    run "cd #{shared_path}/system && gem unpack sinatra && mv sinatra-* sinatra"
  end

  task :symlink do
    run "mkdir -p #{release_path}/vendor/"
    run "ln -nfs #{shared_path}/system/rack #{release_path}/vendor/rack"
    run "ln -nfs #{shared_path}/system/sinatra #{release_path}/vendor/sinatra"
  end
  
  task :mess_with_config_ru do
    run "cd #{release_path} && echo \"require 'vendor/rack/lib/rack'\" > config.nu"
    run "cd #{release_path} && echo \"\\$LOAD_PATH.unshift('vendor/sinatra/lib')\" >> config.nu"
    run "cd #{release_path} && echo \"ENV['GEM_PATH'] = '/home/dust/.gems:/home/dust/lib/ruby/gems/1.8'\" >> config.nu"
    run "cd #{release_path} && echo \"ENV['GEM_HOM'] = '/home/dust/lib/ruby/gems/1.8'\" >> config.nu"
    
    run "cd #{release_path} && cat config.ru >> config.nu"
    run "mv #{release_path}/config.nu #{release_path}/config.ru"
    run "chmod g+w #{release_path}/config.ru"
  end
end