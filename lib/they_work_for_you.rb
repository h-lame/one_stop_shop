require 'sinatra'
require 'twfy'
require './lib/api_keys.rb'
require 'json'

helpers do
  def the_twfy_client
    @twfy_client ||= Twfy::Client.new(ApiKeys.key_for('they_work_for_you'))
  end
  
  def mp_url(the_mp)
    %Q{http://www.theyworkforyou.com/mp/#{the_mp.full_name.downcase.gsub(' ','_')}/#{the_mp.constituency.name.downcase.gsub(' ','_').gsub('&','and')}}
  end
end

get '/twfy/mp/:post_code' do
  @mp = the_twfy_client.mp(:postcode => params[:post_code])
  erb :'twfy/mp'
end
  