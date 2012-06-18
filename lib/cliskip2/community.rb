# -*- coding: utf-8 -*-
require 'cliskip2/base'

module Cliskip2
  class Community < Cliskip2::Base
    lazy_attr_reader :id, :name, :description, :image_file_name, :privacy
  end
end

