require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

target_tango = ["syoujo","musume","imouto","gakuen","simai","kanojo","tuma","tyoukyou","hitoduma","kyousi","hime","ane","naka","koi"]
tango = ["少女","娘","妹","学園","姉妹","彼女","妻","調教","人妻","教師","姫","姉","中","恋"]
target_tango.each_with_index do |x, i|
puts x
p x
`curl -F "sql=SELECT gamename, sellday  FROM gamelist where gamename like '%#{tango[i]}%';" http://erogamescape.dyndns.org/~ap2/ero/toukei_kaiseki/sql_for_erogamer_form.php > #{x}-year.html`
end
