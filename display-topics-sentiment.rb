#!/opt/local/bin/ruby
require './boxfish_lib'
require './PushNotify.rb'
require './weather_u.rb'
require 'httpclient'
require 'json'
require 'uri'
require 'pp'
require './sentiment.rb'
require 'unirest'




#set the current time
time = Time.new
@Y    = time.year
@M    = time.month
@D    = time.day
@HR   = time.hour
@MIN  = time.min
@SEC  = time.sec
@NOW  = "#{@Y}-#{@M}-#{@D}T#{@HR}%3A#{@MIN}%3A48Z"

#set the HOST
host  = "https://api.boxfish.com"

#Set the Type and Time of the Api Call to Make
url   = "#{host}/tags/nested/latest/ie-rte1hd/boxfish/#{@NOW}?limit=5"

puts "[CHANNEL]"
#get Auth , connect and return results
api_boxfish = BoxfishApi.new(host,url)
tags        = api_boxfish.get_api_results
token       = api_boxfish.token

#Parse the Jsdon Tags and print
my_message = api_boxfish.parse_tags(tags)

puts "[EPG] - ie-rte1hd"
puts "service 00"
puts "  lineup: problem"
puts "  Whats on now: problem"

puts " "
puts "[RELATED]"
#get related topics
url                  = "#{host}/related/channels/ie-rte1hd/boxfish/#{@NOW}?limit=9&fields%5B0%5D=all"
related_topics       = BoxfishApi.new(host,url)
related_topics.token = token
results              = related_topics.get_api_results

#Parse the Jsdon Tags and print
related_topics.parse_related(results)

##send a notification
TOKEN      = "aZZ9P1GHnykrXdgh8147BcVy8NXX61"
USER       = "u5Zfg1AJAxuEo7s13yqe799mL3m4uz" 
notify     = PushNotify.new(TOKEN,USER)
notify.PushSend(my_message)



wu_token = '0c3cf6360ff4c0a1'
location = 'DROGHEDA'
weather = GetWeather.new(location,wu_token)
#temp = weather.Results('weather')
#puts temp


#results = sentiment.Result('this is awesome')
#sentiment = GetSentiment.new()
#puts results['results']['sentiment']
  

