require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'
text = File.read("xall_title.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

clist = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}

text = File.read("dall_title.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

dlist = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}
dlist.each do |x|
 puts x.length
end
dlist
