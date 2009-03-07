# function getWardAndBorough($sPostcode){
# $sPostcode=str_replace(" ","",$sPostcode);
# $oDoc = DOMDocument::loadHTMLFile('http://www.writetothem.com/who?pc='
# . $sPostcode);
# $sHtml = $oDoc->saveHTML();
# $sWardAndBorough = '';
# $sWard = '';
# $sBorough = '';
# $aReturn[2];
# if (ereg ("Your ([0-9]) (.*) Councillors represent you ([^.]*)",
# $sHtml, $regs)){
# $sWardAndBorough = $regs[0];
#  
# $sWard = ereg_replace('Your ([0-9])' , '', $sWardAndBorough);
# $sWard = ereg_replace('Councillors represent you (.*)' , '', $sWard);
#  
# $sBorough = ereg_replace('Your ([0-9]) (.*) Councillors represent
# you on the ' , '', $sWardAndBorough);
#  
# $aReturn[0] = trim($sWard);
# $aReturn[1] = trim($sBorough);
# }
#  
# return $aReturn;
# }

require 'sinatra'
require 'hpricot'
require 'open-uri'

get '/council/:post_code' do
  
  doc = Hpricot(open("http://www.writetothem.com/who?pc=#{params[:post_code]}"))
  
  council_col = (doc/"table#repstable tr:nth-of-type(0) th").index {|e| e.inner_html =~ /Your Councillors/}
  
  council_info_text = (doc/"table#repstable tr:nth-of-type(1) td:nth-of-type(#{council_col}) p").inner_html
  
  council_info = council_info_text.match(/Your ([0-9]) (.*) Councillors represent you on the (.*) Council./)
  
  @council = council_info[3]
  @ward = council_info[2]
  erb :council
end