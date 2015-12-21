require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

text1 = File.read("all_year.html", :encoding => Encoding::UTF_8)

html1 = Nokogiri::HTML.parse(text1, nil, "utf8")

list1 = html1.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
unless x.children[1].children[0].nil?
year = x.children[1].children[0].inner_text
year
end
}.compact
group1 = list1.group_by { |x| x.slice(0, 4) }.select { |k, v| k.to_i < 2015  && k.to_i > 1900 }.sort_by { |k, v| k.to_i }
puts "all"
puts "year"
group1.each do |k,v|
  puts k
end
puts "count"
group1.each do |k,v|
  p v.count
end

target_tango = ["syoujo","musume","imouto","gakuen","simai","kanojo","tuma","tyoukyou","hitoduma","kyousi","hime","ane","naka","koi"]
tango = ["少女","娘","妹","学園","姉妹","彼女","妻","調教","人妻","教師","姫","姉","中","恋"]
target_tango.each_with_index do |x, i|
puts x
text = File.read("#{x}-year.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
year = x.children[1].children[0].inner_text
game = x.children[0].children[0].inner_text
{ year: year, game: game }
}.compact.select{ |x| x[:year].to_i > 0 }

group = list.group_by { |x| x[:year].slice(0, 4) }.select { |k, v| k.to_i < 2015 && k.to_i > 1900 }
p list.select { |k| k[:year].to_i < 2015 && k[:year].to_i > 1900 }.sort_by { |x| x[:year]}.first
puts "count-x"
group1.each do |k,v|
  if group[k].nil?
    p 0
  else
    p group[k].count
  end
end
end
