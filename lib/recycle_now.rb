require 'sinatra'
require 'hpricot'
require 'open-uri'

get '/recycle_now/:post_code' do
  
  doc = Hpricot(open("http://www.recyclenow.com/applications/recyclenow_08/banklocator/search_results.rm?place=#{params[:post_code]}"))
  
  recyclable = (doc/"div#box_details div.materialContainer")
  @things = recyclable.inject({}) do |hsh, type|
    hsh[(type/"h3 img").first.attributes['alt']] = (type/"span").map {|s| s.inner_html}
    hsh
  end
  
  erb :recycle_now
end