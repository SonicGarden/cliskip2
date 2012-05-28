# -*- coding: utf-8 -*-
require 'cliskip2/connection'
require 'cliskip2/request'
require 'cliskip2/user'

module Cliskip2
  class Client
    include Cliskip2::Connection
    include Cliskip2::Request

    def current_user
      @current_user ||= Cliskip2::User.new
    end

    def get_board_entries params = {}
      get("/tenants/#{current_user.tenant_id}/board_entries.json", params)
    end
  end
end
