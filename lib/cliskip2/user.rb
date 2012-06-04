# -*- coding: utf-8 -*-
require 'cliskip2/base'

module Cliskip2
  class User < Cliskip2::Base
    lazy_attr_reader :id, :tenant_id
  end
end
