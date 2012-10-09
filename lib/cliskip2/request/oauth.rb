# -*- coding: utf-8 -*-
require 'faraday'
require 'simple_oauth'

module Cliskip2
  module Request
    class Cliskip2OAuth < FaradayMiddleware::OAuth
      # Override Faraday::Utils#parse_nested_query for fixing base-query-string
      # body部分のパラメタ解析方法がskip2のSPで利用しているoauth(0.4.6)とfaradayのoauthモジュールとで異なってしまい認証がうまくいかないためfaraday側のbody部分解析をoauth(0.4.6)相当に合わせている
      # See Faraday::Utils, FaradayMiddleware::OAuth
      def parse_nested_query(qs)
        params = {}
        (qs || '').split(/[&;] */n).each do |p|
          k, v = p.split('=', 2).map { |s| unescape(s) }
          params[k] = v
        end
        params
      end
      def unescape(s) CGI.unescape s.to_s end
    end
  end
end

