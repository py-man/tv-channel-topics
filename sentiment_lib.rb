class GetSentiment
  attr_accessor  :message, :result
  def initialize()
    @message = message
    @result  = result
  end
  
  def Result(message)
    require 'unirest'
    response = Unirest.post "https://community-sentiment.p.mashape.com/text/",
    headers:{
      "X-Mashape-Key" => "4YOURKEY",
      "Content-Type" => "application/x-www-form-urlencoded"
    },
    parameters:{
      "txt" => "#{message}"
    }
    @result = response.body
    return @result
  end
end
