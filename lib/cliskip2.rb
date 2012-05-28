require "cliskip2/version"
require 'cliskip2/client'
require 'cliskip2/config'

module Cliskip2
  extend Config
  class << self
    # Alias for Cliskip2::Client.new
    #
    # @return [Cliskip2::Client]
    def new(options={})
      Cliskip2::Client.new(options)
    end
  end
end
