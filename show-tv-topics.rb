#!/opt/local/bin/ruby
#Get current topics for a TV channel - in this case cnn

require 'httpclient'
require 'json'
require 'uri'
require 'pp'

HOST 		= "https://api.boxfish.com"
VERSION_HEADER 	= "application/vnd.com.boxfish-1+json"
TEST_USER 	= "USERNAME"
TEST_SECRET 	= "SECRET"

http = HTTPClient.new
# Request client auth token
url = "#{HOST}/oauth/token"
r = http.post(url, :body => {:client_id => TEST_USER, :client_secret => TEST_SECRET, :grant_type => "client_credentials"}, :header => {:Accept => VERSION_HEADER})
json = r.body.length == 0 ? {} : JSON.parse(r.body)

# Extract access token from a successful response
access_token = json["access_token"]
raise "Failed to get access token!" unless access_token

#sort and display current time
time = Time.new
Y    = time.year
M    = time.month
D    = time.day
HR   = time.hour
MIN  = time.min
SEC  = time.sec
CUR  = "#{Y}-#{M}-#{D}T#{HR}%3A#{MIN}%3A48Z"
p CUR

# Request a program guide entry using the access token
url = "#{HOST}/tags/nested/latest/us-cnnhd/boxfish/#{CUR}?limit=3"
headers = {:Authorization => "Bearer #{access_token}", :Accept => VERSION_HEADER}
r = http.get(url, :header => headers)
json = r.body.length == 0 ? {} : JSON.parse(r.body)
results = JSON.parse(r.body)

for name in results
  channel = name['channel']
  puts channel
  for data in results
    display = data['segments']
    for dname in display
      ename = dname['entities']
      for mname in ename
        display = mname['displayName']
        puts "   " + display
        unless mname['nestedOccurrences'].nil?
          for i in mname['nestedOccurrences']
            puts "     " + i['displayName']
            unless i['nestedOccurrences'].nil?
              for x in i['nestedOccurrences'] 
                puts "     " + x['displayName']
              end
            end
          end
        end
      end
    end
  end
end

raise "Failed to use access token to get program entries!" unless r.status == 200
