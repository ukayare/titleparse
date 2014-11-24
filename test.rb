require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

(2003..2013).each{|year|
text = File.read("#{year}.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}

nm = Natto::MeCab.new
xx = [] 
list.each{|l|
nm.parse(l) do |n|
  next if n.surface.nil? || n.surface.empty?
  xx << { name: n.surface, type: n.feature.split(',')[0] }
end
}
ucount =  xx.uniq.count
pbar = ProgressBar.new('test', ucount, $stderr)
count = xx.uniq.map{|x|
  co = xx.select{|c| c[:name] == x[:name] && c[:type] == x[:type] }.count
  pbar.inc(1)
  { "name" => x[:name], "type" => x[:type], "count" => co }
}
pbar.finish

File.write("#{year}.json", JSON.generate(count))
p count
}
