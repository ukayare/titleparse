require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

text = File.read("xall_title.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('tbody').children.map{|x|
x.children[0].children[0].inner_text
}

p list
ac = list.count
p list.inject(0){|s,v| s += v.length}.to_f / ac.to_f
p list.sort_by{|x| x.length }[ac/2].length

#p list.select{|x| x.length == 1 }.sort.each{|x| p x }
p list.max_by{|x| x.length }
p list.max_by{|x| x.length }.length
