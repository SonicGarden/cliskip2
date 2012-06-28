# -*- coding: utf-8 -*-
require 'cliskip2/base'

module Cliskip2
  class CommunityParticipation < Cliskip2::Base
    lazy_attr_reader :id, :user_id, :community_id, :admin, :community_name
  end
end

