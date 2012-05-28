# -*- coding: utf-8 -*-
require 'faraday'
require 'faraday_middleware'
require 'oauth'

module Cliskip2
  module Connection
    private

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection options = {}
      connection_options = {
        :headers => {
          :accept => 'application/json',
          :user_agent => user_agent,
        },
        :url => endpoint
      }
      credentials = {
        :consumer_key    => consumer.key,
        :consumer_secret => consumer.secret,
        :token           => access_token.token,
        :token_secret    => access_token.secret
      }
      @connection ||= Faraday.new(connection_options) do |builder|
        builder.request :oauth, credentials
        builder.response :logger
        builder.adapter adapter
      end
    end

    def consumer
#      consumer_key = 'IbHHmpWoNk5oXjfZsbL6'
#      consumer_secret = 'CeQvpKGRrzs3V7KIy69RSZFFYBGlUTylZV2Cb8tR'
      default_options = {
        :site => endpoint,
        :access_token_path => '/api/oauth/access_token'
      }
      @consumer ||= ::OAuth::Consumer.new(consumer_key, consumer_secret, default_options)
    end

    def access_token
#      username = 'admin@test.com'
#      password = 'password'
      @access_token ||= consumer.get_access_token(nil, {}, {
        :x_auth_mode => 'client_auth',
        :x_auth_username => xauth_username,
        :x_auth_password => xauth_password
      })
    end

#    def endpoint
#      'http://localhost:3000'
#    end
  end
end
