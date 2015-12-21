require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

target_povs = [43, 112, 148, 110, 46, 28, 56, 6, 29, 57, 343, 51, 152, 205, 34, 81, 219, 521, 1, 134, 78, 143, 279, 55, 235]
# target_povs = [112, 110, 56, 29, 343, 34, 81, 1, 134, 279]

#target_povs.each do |x|
#  `curl -F "sql=SELECT game, pov, count(*)  FROM povgroups where pov=#{x} group by game, pov;" http://erogamescape.dyndns.org/~ap2/ero/toukei_kaiseki/sql_for_erogamer_form.php > pov#{x}.html`
#end
z = target_povs.map do |x|
text = File.read("pov#{x}.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
game = x.children[0].children[0].inner_text
pov = x.children[1].children[0].inner_text
count = x.children[2].children[0].inner_text

  { "pov" => pov, "count" => count, "game" => game }
}.compact
end.flatten.tap{|x| p x}.compact.group_by { |x| x["game"] }

target_povs.size.times do |t|
y = z.select {|k, v| v.size == (t + 1)}.keys.map(&:to_i)

#p y
print "#{y.size}\n"
#`curl -F "sql=SELECT gamename, furigana  FROM gamelist where id in (#{y.join(',')})" http://erogamescape.dyndns.org/~ap2/ero/toukei_kaiseki/sql_for_erogamer_form.php > povgame#{t + 1}.html`
end
#all_povs = povs.map{ |x| x.map { |y| y["pov"]}}.flatten.uniq
#all_title_count = titles.size

#included_pov = all_povs.select { |pov|
#  povs.all? { |x| x.any? { |y| y["pov"] == pov} }
#}

#p list
