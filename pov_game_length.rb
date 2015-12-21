require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

target_povs = [43, 112, 148, 110, 46, 28, 56, 6, 29, 57, 343, 51, 152, 205, 34, 81, 219, 521, 1, 134, 78, 143, 279, 55, 235]
#z = target_povs.map do |x|
text = File.read("2014.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

title = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}
title.slice! 0
puts title.size
puts "#{title.inject(0) {|sum, i| sum + i.length} /title.size.to_f}"
#end.each do |x|
#x.slice! 0
#nm = Natto::MeCab.new
#xx = [] 
#x.each{|l|
#  y = {title: l, count: 0}
#nm.parse(l) do |n|
#  next if n.surface.nil? || n.surface.empty?
#  y[:count] += 1
#end
#  xx << y[:count]
#}
#  print sprintf("%.2f", ( xx.inject(0) {|sum, n| sum + n }.to_f / xx.size.to_f )) + "\n"
#end
