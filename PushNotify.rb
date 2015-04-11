class PushNotify
  attr_accessor  :message, :token, :user
  def initialize(token,user)
    @message = message
    @token   = token
    @user    = user
  end
  
  def PushSend(message)
    require "net/https"
    @message = message
    url = URI.parse("https://api.pushover.net/1/messages.json")
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data({
      :token   => @token,
      :user    => @user,
      :message => @message,
    })
    
    res = Net::HTTP.new(url.host, url.port)
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER
    res.start {|http| http.request(req) }
  end
end