class BoxfishApi
  attr_accessor  :host, :url, :results, :token
  def initialize(host,url)
    @HOST               = host
    @URL                = url
    @TEST_USER          = "NAME"
    @TEST_SECRET        = "Secret"
    @VERSION_HEADER     = "application/vnd.com.boxfish-1+json"
    @results            = results
    @token              = token
  end
  
  
  def get_api_results
    http = HTTPClient.new
    # Request client auth token
    url = "#{@HOST}/oauth/token"
    r = http.post(url, :body => {:client_id => @TEST_USER, :client_secret => @TEST_SECRET, :grant_type => "client_credentials"}, :header => {:Accept => @VERSION_HEADER})
    json = r.body.length == 0 ? {} : JSON.parse(r.body)

    # Extract access token from a successful response
    access_token = json["access_token"]
    @token = access_token
    raise "Failed to get access token!" unless access_token

    # Request a program guide entry using the access token
    url = @URL
    headers = {:Authorization => "Bearer #{access_token}", :Accept => @VERSION_HEADER}
    r = http.get(url, :header => headers)
    json = r.body.length == 0 ? {} : JSON.parse(r.body)
    @results = JSON.parse(r.body)
    raise "Failed to use access token to get program entries!" unless r.status == 200
    return @results
  end
  
  require './sentiment_lib.rb'
  require 'unirest'
  def parse_tags(results)
     for name in results
      channel = name['channel'].capitalize
      puts channel
      for data in results
        display = data['segments']
        for dname in display
          ename = dname['entities']
          for mname in ename
            display = mname['displayName']
            sentiment = GetSentiment.new()
            results = sentiment.Result(display)
            response = Unirest.get "https://webknox-entities.p.mashape.com/text/entities?text=#{display}",
            headers:{
              "X-Mashape-Key" => "YOURMASHAPEKEY"
            }
            a = " "
            a = response.body unless response.body.length == 0
            puts "   " + display + " => Sentiment #{results['result']['sentiment']} => Confidence: #{results['result']['confidence']} Entity Type: #{a[0]['type']}"
            unless mname['nestedOccurrences'].nil?
              for i in mname['nestedOccurrences']
                display1 = i['displayName']
                sentiment = GetSentiment.new()
                results = sentiment.Result(display1)
                puts "     :" + display1 + " => Sentiment: #{results['result']['sentiment']} => Confidence: #{results['result']['confidence']}"
                unless i['nestedOccurrences'].nil?
                  for x in i['nestedOccurrences'] 
                    display2 = x['displayName']
                    sentiment = GetSentiment.new()
                    results = sentiment.Result(display2)
                    puts "       :" + display2 + " => Sentiment: #{results['result']['sentiment']} => Confidence: #{results['result']['confidence']}"
         
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  
  def parse_related(results)
    begin
      for nested in results[0]
        for result in nested[1]
            uri  =  result['url']
            desc =  result['description']
            u    = URI.parse("#{uri}")  
            puts "[ " +  u.host + " ]"
            puts "  " + result['title'].upcase 
            puts "    " + desc 
            puts " "
        end
      end
    rescue => e
    end
  end
end  
