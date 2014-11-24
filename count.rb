require 'json'
text = File.read("test.html", :encoding => Encoding::UTF_8)
json = []
open("result.txt") do |io|
  json = JSON.load(io) #=> [1, 2, 3, {"foo"=>"bar"}]
end
json = json.sort_by{|x| x["count"] }
#json = json.select{|x| x["type"] == "動詞"}
json.each do |x|
 p x
end
