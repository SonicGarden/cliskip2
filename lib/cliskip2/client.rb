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

    # Create new user by params
    # @return [Cliskip2::User]
    def create_user params
      user_attr = post("/admin/tenants/#{current_user.tenant_id}/users.json", params)
      Cliskip2::User.new(user_attr['user'])
    end

    # Get the user by params
    # @return [Cliskip2::User]
    def get_user params
      user_attr = get("/tenants/#{current_user.tenant_id}/users/show_by_params.json", params)
      Cliskip2::User.new(user_attr['user'])
    end

    # Update the user by params
    # @return [Cliskip2::User]
    def update_user params
      user = get_user :email => params[:user][:email]
      user_attr = put("/admin/tenants/#{current_user.tenant_id}/users/#{user.id}.json", params)
      Cliskip2::User.new(user_attr['user'])
    end
  end
end
