require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'
target_tango = ["syoujo","musume","imouto","gakuen","simai","kanojo","tuma","tyoukyou","hitoduma","kyousi","hime","ane","naka","koi"]

target_tango.each do |x|
puts x
text = File.read("#{x}.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}

ltitle = list.group_by{|x|
x.length
}

y = {}

t =  "length\n"
ltitle.each{|key, value|
  t += "#{key}\n"
}

t +=  "count\n"
ltitle.each{|key, value|
  t += "#{value.count}\n"
}

puts t
end
