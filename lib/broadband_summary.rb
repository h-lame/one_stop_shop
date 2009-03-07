require 'sinatra'
require 'hpricot'
require 'net/http'

helpers do
end

get '/broadband/:post_code' do
  samknows = Net::HTTP.start('www.samknows.com')
  req = Net::HTTP::Post.new('/broadband/checker2.php?p=summary')
  req.set_form_data({:postcode => params[:post_code]})
  res = samknows.request(req)
  @the_results = Hpricot(res.body)
  erb :broadband
end
  