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
mixhash = Hash.new
log = Hash.new

class String
  def word_wrap(line_width = 80)
    self.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n")
  end
end

#/^(?<name>.?.?.?.?.?(主席|委員|部長|署長|局長|副教授|教授|處長|執行秘書|秘書|隊長|科長|組長|參事|法官|在場人員|調查官|董事|理事長|經理|所長|次長|司長|發言|召集|主任|院長).?.?.?.?.?.?)：(?<content>.+)/
#/^(?<name>\S*[主席|委員|部長|署長]+\S*：+)(?<content>\S+)/m
Dir.glob("lyfolder/*.txt") do |my_text_file|
	puts "working on: #{my_text_file}..."
	filename = File.basename("#{my_text_file}", ".txt") 
	html_doc = File.read("#{my_text_file}")
	#numarray = Array.new(init_count)
	regex = /^(?<name>.?.?.?.?.?(主席|委員|部長|署長|局長|副教授|教授|處長|執行秘書|秘書|隊長|科長|校長|組長|參事|法官|在場人員|調查官|董事|理事長|經理|所長|次長|司長|發言|召集|主任|院長|書面意見|研究員|會長|義務律師|副會長|執行長|參謀長|負責人|先生|主計長|女士|總臺長|審計長).?.?.?.?.?.?)：(?<content>.+)/
	#puts html_doc


	name, content = html_doc.scan(regex).transpose

	unless name.nil?
		h = Hash.new.tap { |h| name.zip(content).each { |k, v| (h[k] ||= []) << v } }
	end

	#keys = h.keys
   	unless h.nil?
		h.each do |key, array|
			puts "#{key}"
			join_array = array.join("\n")
			join_array = join_array.gsub("，"," ")
			join_array = join_array.gsub("、"," ")
			join_array = join_array.gsub("。"," ")
			wrap_array = join_array.word_wrap
			Dir.chdir("lyparsefolder") 
			File.open("#{filename}_#{key}.txt", 'a+') do |f|
    			f.puts("#{wrap_array}")
    			Dir.chdir("..")
		end
	end
	
	#i = 0
	#puts content[0]
	#length = name.size
	#puts length
	#for i in name do
		#puts i
		#if log.eql? i
			#log[:name[i]] = content[i]
		#else log = {:name[i] => content[i]} 
		#end
	#end

	#puts log






	


	#inter = inter.gsub(/(【.*】)/,"")
	#inter = inter.gsub("，"," ")
	#inter = inter.gsub("。"," ")
	#inter = inter.word_wrap
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
	#interarray.push(inter)
	#count = numarray.last
	#count +=1
	#numarray.push(count)

	

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
				even +=1
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
				blue +=1
			elsif tag.at(1).match("自由時報")
				agency = 2
				green +=1
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
	
	end

/p even 
p blue
p green/
/p datearray
p agencyarray
p positionarray
p arthurarray/
/puts "#{mixhash['date']}"/
#table = [numarray ,interarray].transpose

#CSV.open("file.csv", "w:UTF-8") do |csv|
#  table.each do |row|
#  	csv << row
#  end


end