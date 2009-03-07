require 'rubygems'
require 'sinatra'

helpers do
  def urlify_post_code(post_code)
    post_code.gsub(' ', '_').upcase
  end
  
  def deurlify_post_code(post_code)
    post_code.gsub('_', ' ')
  end
  
  def valid_post_code?(post_code)
    # POST CODE validator via - http://snipplr.com/view/7990/validate-uk-postcode/
    post_code =~ /^([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\ [0-9][ABD-HJLNP-UW-Z]{2}|(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))$/
  end
  
  def are_we_sorry?
    if @sorry
      erb :sorry
    else
      ''
    end
  end
end

get '/' do
  erb :index
end

get '/for' do
  if valid_post_code?(params[:post_code].upcase)
    redirect "/for/#{urlify_post_code(params[:post_code])}"
  else
    redirect '/sorry'
  end
end

get '/for/:post_code' do
  @post_code = deurlify_post_code(params[:post_code])
  if valid_post_code?(@post_code)
    erb :post_code
  else
    redirect '/sorry'
  end
end

get '/sorry' do
  @sorry = true
  erb :index
end