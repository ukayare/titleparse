require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

#(2003..2014).each do |x|
#p x
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
ac =  xxx.inject(0){|sum, (key, value)| sum += value.size }
#p ac
p xxx.inject(0){|s,(k,v)| s += k * v.length}.to_f / ac.to_f
p xx.sort_by{|x| x[:count] }[ac/2][:count]
#xx.select{|x| x[:count] == 1 }.each{|x| p x[:title] }
p xx.max_by{|x| x[:count] }[:title]
p xx.max_by{|x| x[:count] }[:count]
#end
