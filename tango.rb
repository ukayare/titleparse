require 'json'
require 'natto'
require 'nokogiri'
require 'progressbar'
topic_word = "青空"
excep = [
"1","2","3","〜","～","-","!","DVDPG","DVD","ー",".","－","!!","版","!～","編",")","(","ら","the","さん","of","話", "​", "The", "/", "+", "!?"
]
#target_povs = [43, 112, 148, 110, 46, 28, 56, 6, 29, 57, 343, 51, 152, 205, 34, 81, 219, 521, 1, 134, 78, 143, 279, 55, 235]
exname = ["少女","娘","妹","学園","姉妹","彼女","妻","調教","人妻","教師","姫","姉","中", "恋"]
#target_povs.each do |i|
#25.times.each do |i|
text = File.read("2014.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
x.children[0].children[0].inner_text
}
nm = Natto::MeCab.new
xx = [] 
list.each{|l|
#  if l =~ /#{topic_word}/
nm.parse(l) do |n|
  next if n.surface.nil? || n.surface.empty?
  xx << { name: n.surface, type: n.feature.split(',')[0] }
end
#  end
}
ucount =  xx.uniq.count
pbar = ProgressBar.new('test', ucount, $stderr)
json = xx.uniq.map{|x|
  co = xx.select{|c| c[:name] == x[:name] && c[:type] == x[:type] }.count
  pbar.inc(1)
  { "name" => x[:name], "type" => x[:type], "count" => co }
}
pbar.finish
#puts "pov#{ i}"
json = json.select{|x| x["type"] == "名詞" && !excep.include?(x["name"])} # && !exname.include?(x["name"])}
json = json.sort_by{|x| x["count"] }.reverse
json[0,10].each_with_index do |x,index|
 puts "#{index + 1}位:#{x['name']}(#{x['count']})"#, #{x['type']}"
end
#end
