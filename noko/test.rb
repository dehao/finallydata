#!/usr/bin/ruby
# encoding: UTF-8

require 'nokogiri'
require 'open-uri'
require 'csv'
require 'date'
require "active_support/core_ext/object/blank"

even = 0
blue = 0
green = 0
init_count = [0]
numarray = Array.new(init_count)
datearray = Array.new(init_count)
agencyarray = Array.new(init_count)
positionarray = Array.new(init_count)
arthurarray = Array.new(init_count)
contentarray = Array.new(init_count)
interarray = Array.new(init_count)
filena = Array.new(init_count)
mixhash = Hash.new

class String
  def word_wrap(line_width = 80)
    self.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n")
  end
end


Dir.glob("newsfolder/*.htm") do |my_text_file|
  puts "working on: #{my_text_file}..."
  filename = File.basename("#{my_text_file}", ".htm") 

	html_doc = Nokogiri::HTML( File.open("#{my_text_file}") )
	i = 0
	y = 2
	numarray = Array.new(init_count)
	k = html_doc.xpath("//blockquote").size
	k = k / 3
	

	while i < k do
		agency = 0
		inter = html_doc.xpath("//blockquote")[y].text
		parse = html_doc.xpath("//blockquote")[y].text
		parse = parse.gsub(/(【系統號.*】)/,"")
	

		if parse.match(/(【.*】)/).nil?
			datearray.push(0)
			agencyarray.push(0)
		else	
			parse = parse.match(/(【.*】)/)[0]
			parse = parse.gsub(/【/,"")
			parse = parse.gsub(/】/,"")
			parse = parse.split(" ")
			sourcedate = Date.parse(parse.at(0))
			datearray.push(sourcedate.strftime("%b %d %Y"))
			agencyarray.push(parse.at(1))
		end



		#news = html_doc.xpath("//blockquote/a[@class='aa']")[i].text
		#splitnews = news.split("】")
		#puts splitnews
		#cleansplitnews = splitnews.first.gsub("【","")
		#tag = cleansplitnews.split(" ")
		#cleancontent = splitnews.at(1).gsub("\n","")
		#cleancontent = cleancontent.gsub("，","")
		#sourcedate = Date.parse(tag.at(0))
		#datearray.push(sourcedate.strftime("%b %d %Y"))
		#agencyarray.push(tag.at(1))
		#pospatteren = /第(\w*\d*)版/
		#pos = pospatteren.match(tag.at(2))
		#if pos.to_a.empty?
		#	pos = ("None")
		#end
		#positionarray.push(pos[1])
		#arthurarray.push(tag.at(3))
		#contentarray.push(cleancontent)
		inter = inter.gsub(/(【.*】)/,"")
		inter = inter.gsub(/(（.*）)/,"")
		inter = inter.gsub(/(〔.*〕)/,"")
		inter = inter.gsub("，"," ")
		inter = inter.gsub("。"," ") 
		inter = inter.word_wrap
		interarray.push(inter)
		count = numarray.last
		count +=1
		numarray.push(count)
		name = "#{filename}_#{count}.txt".to_s
		filena.push(name)

		Dir.chdir("parsefolder") 
			File.open("#{filename}_#{count}.txt", 'a+') do |f|
    			f.puts("#{inter}")
    			Dir.chdir("..")

		/mixhash[:date] = tag.at(0)/
		/mixhash.store("date",tag.at(0))
		mixhash[:agency] = tag.at(1)
		mixhash[:position] = tag.at(2)
		mixhash[:arthur] = tag.at(3)
		mixhash['date'] = (tag.at(0))/

		'''
			if tag.at(1).match("各報圖表")
				agency = 0
			elsif tag.at(1).match("聯合報")
				agency = 1
			elsif tag.at(1).match("蘋果日報")
				agency = 0
			elsif tag.at(1).match("工商時報") 
				agency = 1
			elsif tag.at(1).match("旺報") 
				agency = 0
			elsif tag.at(1).match("經濟日報") 
				agency = 1
			elsif tag.at(1).match("中央社")  
				agency = 1
			elsif tag.at(1).match("青年日報") 
				agency = 0
			elsif tag.at(1).match("台灣新生報") 
				agency = 2
			elsif tag.at(1).match("台灣立報") 
				agency = 2
			elsif tag.at(1).match("台灣時報") 
				agency = 2
			elsif tag.at(1).match("中華日報") 
				agency = 1
			elsif tag.at(1).match("民眾日報") 
				agency = 2
			elsif tag.at(1).match("聯合晚報") 
				agency = 1
			elsif tag.at(1).match("自立晚報") 
				agency = 0
			elsif tag.at(1).match("中國時報") 
				agency = 1
			elsif tag.at(1).match("自由時報")
				agency = 2
			elsif tag.at(1).match("金門日報")
				agency = 0
			elsif tag.at(1).match("馬祖日報")
				agency = 0
			elsif tag.at(1).match("東方報")
				agency = 0
			elsif tag.at(1).match("更生日報")
				agency = 0
			elsif tag.at(1).match("聯統日報")
				agency = 0
			elsif tag.at(1).match("民生報")
				agency = 0
			elsif tag.at(1).match("星報")
				agency = 0
			elsif tag.at(1).match("台灣新聞報")
				agency = 0
			elsif tag.at(1).match("自立早報")
				agency = 0
			elsif tag.at(1).match("中央日報")
				agency = 0
			elsif tag.at(1).match("台灣日報")
				agency = 0
			elsif tag.at(1).match("環球日報")
				agency = 0
			elsif tag.at(1).match("首都早報")
				agency = 0
			elsif tag.at(1).match("自由日報")
				agency = 0
			elsif tag.at(1).match("中時晚報")
				agency = 0
			elsif tag.at(1).match("勁晚報")
				agency = 0
			elsif tag.at(1).match("大華晚報")
				agency = 0
			elsif tag.at(1).match("民族晚報")
				agency = 0
			else agency = 35
			end
		'''
		i +=1
		y +=3
		

    	
		end

		

	end

/p even 
p blue
p green/
/p datearray
p agencyarray
p positionarray
p arthurarray/
/puts "#{mixhash['date']}"/
table = [filena ,datearray, agencyarray].transpose

CSV.open("file.csv", "w:UTF-8") do |csv|
  table.each do |row|
  	csv << row
  end


end
end
