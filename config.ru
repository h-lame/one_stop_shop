require 'rubygems'
require 'sinatra'

root_dir = File.dirname(__FILE__)

disable :run
set :views, File.join(root_dir, 'views')
set :app_file, File.join(root_dir, 'one_stop_shop.rb')
set :environment, :production

require 'one_stop_shop.rb'
run Sinatra::Application