# -*- coding: utf-8 -*-
require 'cliskip2/connection'
require 'cliskip2/request'
require 'cliskip2/user'
require 'cliskip2/config'

module Cliskip2
  class Client
    include Cliskip2::Connection
    include Cliskip2::Request

    attr_accessor *Config::VALID_OPTIONS_KEYS

    # Initializes a new API object
    #
    # @param attrs [Hash]
    # @return [Cliskip2::Client]
    def initialize(attrs={})
      attrs = Cliskip2.options.merge(attrs)
      Config::VALID_OPTIONS_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end

    def current_user
      user_attr = get("/api/get_current_user")
      @current_user ||= Cliskip2::User.new(user_attr['user'])
    end

    def get_board_entries params = {}
      get("/tenants/#{current_user.tenant_id}/board_entries.json", params)
    end

    def post_user params
      post("/admin/tenants/#{current_user.tenant_id}/users.json", params)
    end
  end
end
