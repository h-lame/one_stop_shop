require 'rubygems'
require 'sinatra'

Sinatra::Application.default_options.merge!(
  :run => false,
  :environment => :production
)

require 'one_stop_shop.rb'
run Sinatra::Application