# tv-channel-topics
Using Boxfish Api to get Channel Topics and sentiment - send notifications

You will need to get an API key from boxfish and an API key for sentiment from MASHAPE

boxfish_lib.rb     - connect and get channel information
show-tv-topics.rb  - show nested topics from a current TV show
PushNotify.rb      - send push notification 
sentiment_lib.rb   - get the sentiment for topics word

[display-topics-sentiment.rb]
connect to boxfish api - get current tv channel topics and display the sentiment for each one.
Notify / Alert on certain topics

--example
  [CHANNEL]
Ie-rte1hd
   Vhi => Sentiment Neutral => Confidence: 50.0000 Entity Type: PER
   Mini Marathon => Sentiment Neutral => Confidence: 50.0000 Entity Type: PER
     :Movements => Sentiment: Neutral => Confidence: 50.0000
     :Stitches => Sentiment: Neutral => Confidence: 50.0000
   Vhi => Sentiment Neutral => Confidence: 50.0000 Entity Type: PER
   David Gillick => Sentiment Neutral => Confidence: 61.2201 Entity Type: PER
     :Nutritional => Sentiment: Neutral => Confidence: 50.0000
     :Mini Marathon => Sentiment: Neutral => Confidence: 50.0000
     :Cook => Sentiment: Neutral => Confidence: 50.0000
   Vhi => Sentiment Neutral => Confidence: 50.0000 Entity Type: PER
   Laois => Sentiment Neutral => Confidence: 50.0000 Entity Type: City
   Geri Maye => Sentiment Neutral => Confidence: 50.0000 Entity Type: PER
   Iceland => Sentiment Neutral => Confidence: 50.0000 Entity Type: Country
     :Three Nights => Sentiment: Neutral => Confidence: 50.0000
   ADVERT => Sentiment Neutral => Confidence: 50.0000 Entity Type: PER
