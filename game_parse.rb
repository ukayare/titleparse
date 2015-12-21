require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

target_povs = [43, 112, 148, 110, 46, 28, 56, 6, 29, 57, 343, 51, 152, 205, 34, 81, 219, 521, 1, 134, 78, 143, 279, 55, 235]
#target_povs = [112, 110, 56, 29, 343, 34, 81, 1, 134, 279]

#target_povs.each do |x|
#  `curl -F "sql=SELECT game, pov, count(*)  FROM povgroups where pov=#{x} group by game, pov;" http://erogamescape.dyndns.org/~ap2/ero/toukei_kaiseki/sql_for_erogamer_form.php > pov#{x}.html`
#end
z = target_povs.map do |x|
text = File.read("pov#{x}.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
game = x.children[0].children[0].inner_text
game
}.compact.select{ |x| x.to_i > 0 }
p list
`curl -F "sql=SELECT gamename, furigana  FROM gamelist where id in (#{list.join(',')})" http://erogamescape.dyndns.org/~ap2/ero/toukei_kaiseki/sql_for_erogamer_form.php > povtogame#{x}.html`
end.flatten.tap{|x| p x}.compact
