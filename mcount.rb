require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

#(2003..2013).each{|year|
text = File.read("2014.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}

nm = Natto::MeCab.new
xx = [] 
list.each{|l|
  y = {title: l, count: 0}
nm.parse(l) do |n|
  next if n.surface.nil? || n.surface.empty?
  y[:count] += 1
end
  xx << y
}
xxx = xx.group_by{|x| x[:count]}
puts "length"
xxx.each{|key, value| p key }
puts "count"
xxx.each{|key, value| p value.size }
