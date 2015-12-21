require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

#target_povs = [43, 112, 148, 110, 46, 28, 56, 6, 29, 57, 343, 51, 152, 205, 34, 81, 219, 521, 1, 134, 78, 143, 279, 55, 235]
target_tango = ["syoujo","musume","imouto","gakuen","simai","kanojo","tuma","tyoukyou","hitoduma","kyousi","hime","ane","naka","koi"]
#target_povs.each do |x|
target_tango.each do |x|
text = File.read("#{x}.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}

ac = list.count
puts "単語:#{x}"
puts "作品数:#{ac}"
puts "平均文字数:#{list.inject(0){|s,v| s += v.length}.to_f / ac.to_f}"
puts "中央値:#{list.sort_by{|x| x.length }[ac/2].length}"

#p list.select{|x| x.length == 1 }.sort.each{|x| p x }
puts "最大文字数:#{list.max_by{|x| x.length }.length}"
puts "最大文字数作品:#{list.max_by{|x| x.length }}"
puts ""
end
