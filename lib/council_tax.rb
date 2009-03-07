# http://www.lexical.org.uk/rewiredstate/council-tax-band-d.json

require 'sinatra'
require 'open-uri'
require 'json'
require 'google_chart'

helpers do
  def council_to_json_key(council)
    case council
    when /^Westminster/
      'Westminster'
    else
      council
    end
  end
end

get '/council_tax/:council' do
  json = JSON.parse(open('http://www.lexical.org.uk/rewiredstate/council-tax-band-d.json').read)
  @data = json[council_to_json_key(params[:council])]
  @gc = GoogleChart::LineChart.new('400x200', 'Line Chart', false) do |lc|
    lc.data 'Band D', @data.map {|d| d[1]}, '0000ff'
    lc.axis :y, :range => [@data.map {|d| d[1]}.min, @data.map {|d| d[1]}.max], :label => 'Cost'
    lc.axis :x, :range => [@data.map {|d| Date.parse(d[0]).year}.min, @data.map {|d| Date.parse(d[0]).year}.max], :label => 'Year'
  end
  erb :council_tax
end
