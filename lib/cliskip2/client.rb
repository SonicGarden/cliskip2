# -*- coding: utf-8 -*-
require 'cliskip2/connection'
require 'cliskip2/request'
require 'cliskip2/user'
require 'cliskip2/community'
require 'cliskip2/community_participation'
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

    # ========================================
    # User APIs
    # ========================================

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
    rescue Faraday::Error::ResourceNotFound => e
      nil
    end

    # Update the user by params
    # @return [Cliskip2::User]
    def update_user params
      user = get_user :email => params[:user][:email]
      user_attr = put("/admin/tenants/#{current_user.tenant_id}/users/#{user.id}.json", params)
      Cliskip2::User.new(user_attr['user'])
    end

    # ========================================
    # Community APIs
    # ========================================

    # Search communities by some conditions
    # @return [Array<Cliskip2::Community>]
    def search_communities params
      community_attrs = get("/tenants/#{current_user.tenant_id}/communities.json", params)
      community_attrs.map {|community_attr| Cliskip2::Community.new(community_attr['community']) }
    end

    # Get the community-member by params
    # @return [Cliskip2::CommunityParticipation]
    def get_community_member community, params
      community_participation_attr = get("/tenants/#{current_user.tenant_id}/communities/#{community.id}/community_participations/show_by_params.json", params)
      Cliskip2::CommunityParticipation.new(community_participation_attr['community_participation'])
    rescue Faraday::Error::ResourceNotFound => e
      nil
    end

    # Join the community by the target-community and params
    # @return [Cliskip2::CommunityParticipation]
    def join_community community, user
      community_participation_attr = post("/tenants/#{current_user.tenant_id}/communities/#{community.id}/community_participations.json", {:community_participation => {:user_id => user.id}})
      Cliskip2::CommunityParticipation.new(community_participation_attr['community_participation'])
    end

    # Leave from the community by the target-community and params
    # @return [Cliskip2::CommunityParticipation]
    def leave_community community, community_participation
      community_participation_attr = delete("/tenants/#{current_user.tenant_id}/communities/#{community.id}/community_participations/#{community_participation.id}.json")
      Cliskip2::CommunityParticipation.new(community_participation_attr['community_participation'])
    end
  end
end
