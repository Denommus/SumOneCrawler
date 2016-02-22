#!/usr/bin/env ruby
require 'tweetstream'
require 'rest-client'

TweetStream.configure do |config|
  config.consumer_key = ENV["CONSUMER_KEY"]
  config.consumer_secret = ENV["CONSUMER_SECRET"]
  config.oauth_token = ENV["OAUTH_TOKEN"]
  config.oauth_token_secret = ENV["OAUTH_TOKEN_SECRET"]
  config.auth_method = :oauth
end

TweetStream::Client.new.track(ARGV[0]) do |status|
  RestClient.post 'http://localhost:3000/tweets', tweet: {
                    user: status.user.screen_name,
                    text: status.text,
                    tweeted_at: status.created_at
                  }
end
