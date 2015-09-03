require 'nokogiri'
require 'open-uri'

def comment_pages
 threadlist = []
 doc = Nokogiri::HTML(open("https://news.ycombinator.com/"))
 doc.css("td[class='subtext'] a").each { |element| threadlist << element['href'] if element['href'].include?("item") }

 threadlist.uniq
end

def grab_users(threads)
 users = []

 threads.each do |current_thread|
   puts "current thread: #{current_thread}"
   nowthread = Nokogiri::HTML(open("https://news.ycombinator.com/#{current_thread}"))
   nowthread.css("span[class='comhead'] a").each { |element| users << element['href'] if element['href'].include?("user") }
   sleep 1
 end
 users.uniq
end


def catch_him(all_users)

all_users.each do |current_user|
 p now_user = Nokogiri::HTML(open("https://news.ycombinator.com/#{current_user}"))
 sleep 3
   username = now_user.css("table#hnmain table tr td")[4].text
   age      = now_user.css("table#hnmain table tr td")[6].text.tr("^0-9", '')
   karma    = now_user.css("table#hnmain table tr td")[8].text

  puts "User: #{username} Age: #{age} Karma: #{karma}"

 end
end

list = comment_pages
all_users = grab_users(list)

catch_him(all_users)
