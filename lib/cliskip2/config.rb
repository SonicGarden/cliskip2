# -*- coding: utf-8 -*-
require "cliskip2/version"

module Cliskip2
  module Config
    # The HTTP connection adapter that will be used to connect if none is set
    DEFAULT_ADAPTER = :net_http

    # The Faraday connection options if none is set
    DEFAULT_CONNECTION_OPTIONS = {}

    # The consumer key if none is set
    DEFAULT_CONSUMER_KEY = nil

    # The consumer secret if none is set
    DEFAULT_CONSUMER_SECRET = nil

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = nil

    # The xauth username if none is set
    DEFAULT_XAUTH_USERNAME = nil

    # The xauth password if none is set
    DEFAULT_XAUTH_PASSWORD = nil

    # The value sent in the 'User-Agent' header if none is set
    DEFAULT_USER_AGENT = "Cliskip2 Ruby Gem #{Cliskip2::VERSION}"

    # An array of valid keys in the options hash when configuring a {Twitter::Client}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :connection_options,
      :consumer_key,
      :consumer_secret,
      :endpoint,
      :xauth_username,
      :xauth_password,
      :user_agent
    ]

    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.consumer_key       = DEFAULT_CONSUMER_KEY
      self.consumer_secret    = DEFAULT_CONSUMER_SECRET
      self.endpoint           = DEFAULT_ENDPOINT
      self.xauth_username     = DEFAULT_XAUTH_USERNAME
      self.xauth_password     = DEFAULT_XAUTH_PASSWORD
      self.user_agent         = DEFAULT_USER_AGENT
      self
    end
  end
end
