require 'rubygems'
require 'sinatra'

disable :run
set :app_file, 'one_stop_shop.rb'
set :environment, :production

require 'one_stop_shop.rb'
run Sinatra::Application