require 'natto'
require 'nokogiri'
require 'progressbar'
require 'json'

titles = ["anesitu", "aisimai4", "euphoria", "haruka", "hensin", "kamikaze", "kanojo3", "kyonyuu", "loveca", "mange", "mange2", "osaama", "primal", "serina", "sisters", "tikan3", "tumasibo"]
povs = titles.map{|year|
text = File.read("#{year}.html", :encoding => Encoding::UTF_8)

html = Nokogiri::HTML.parse(text, nil, "utf8")

list = html.xpath('//div[@id="query_result_main"]').css('table').children.map{|x|
pov = x.children[0].children[0].inner_text
count = x.children[1].children[0].inner_text

  { "pov" => pov, "count" => count}
}.compact

# File.write("#{year}.json", JSON.generate(list))
}

all_povs = povs.map{ |x| x.map { |y| y["pov"]}}.flatten.uniq
all_title_count = titles.size

included_pov = all_povs.select { |pov|
  povs.all? { |x| x.any? { |y| y["pov"] == pov} }
}.map(&:to_i).reject(&:zero?)

p included_pov
