require 'json'
excep = [
"1","2","3","〜","～","-","!","DVDPG","DVD","ー",".","－","!!","版","!～","編",")","(","ら","the","さん","of","話"
]

(2003..2013).each do |x|
p x
json = nil
open("#{x}.json") do |io|
  json = JSON.load(io) #=> [1, 2, 3, {"foo"=>"bar"}]
end
json = json.select{|x| x["type"] == "名詞" && !excep.include?(x["name"])}
json = json.sort_by{|x| x["count"] }.reverse
json[0,10].each_with_index do |x,index|
 puts "#{index + 1}位:#{x['name']}(#{x['count']})"#, #{x['type']}"
end
end
