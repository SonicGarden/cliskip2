# -*- coding: utf-8 -*-
require 'faraday'
require 'faraday_middleware'
require 'oauth'
# see oauth-0.4.6/lib/oauth/consumer.rb
# For using OpenSSL::SSL::VERIFY_NONE
::OAuth::Consumer::CA_FILE = nil
require 'cliskip2/request/oauth'

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
        :url => endpoint,
        :ssl => {:verify => false}
      }
      credentials = {
        :consumer_key    => consumer.key,
        :consumer_secret => consumer.secret,
        :token           => access_token.token,
        :token_secret    => access_token.secret,
        :proxy => proxy
      }
      @connection ||= Faraday.new(connection_options) do |builder|
        builder.response :raise_error
        builder.response :json
        builder.request :url_encoded
        builder.use Cliskip2::Request::Cliskip2OAuth, credentials
        builder.adapter adapter
      end
    end

    def consumer
      default_options = {
        :site => endpoint,
        :access_token_path => '/api/oauth/access_token',
        :proxy => proxy
      }
      @consumer ||= ::OAuth::Consumer.new(consumer_key, consumer_secret, default_options)
    end

    def access_token
      @access_token ||= consumer.get_access_token(nil, {}, {
        :x_auth_mode => 'client_auth',
        :x_auth_username => xauth_username,
        :x_auth_password => xauth_password
      })
    end
  end
end
