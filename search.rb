require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

text = File.read("2012.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}

s = list.select{|x| x =~ /俺/}.each{|x| p x}

