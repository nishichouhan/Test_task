class TwitterService
  def self.post_tweet(content,current_user)
    url = URI("https://api.twitter.com/2/tweets")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Content-Type'] = 'application/json'
    request['Authorization'] = twitter_oauth_header(current_user)
    request['Cookie'] = 'guest_id=v1%3A170668177832395873'
    request.body = JSON.dump({
      'text' => content
    })

    response = https.request(request)
    response.read_body
  end

  private

  def self.twitter_oauth_header(current_user)
    "OAuth oauth_consumer_key=\"#{current_user.consumer_key}\",oauth_token=\"#{current_user.access_token}\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1706710413\",oauth_nonce=\"R72SmR1327z\",oauth_version=\"1.0\",oauth_signature=\"lGcN49ppCF9T%2FWWweIVIWCeuHIQ%3D\""
  end
end







