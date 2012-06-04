# -*- coding: utf-8 -*-
require 'faraday'
require 'simple_oauth'

module Cliskip2
  module Request
    class Cliskip2OAuth < FaradayMiddleware::OAuth
      # Override Faraday::Utils#parse_nested_query for fixing base-query-string
      # body部分のパラメタ解析方法がskip2のSPで利用しているoauth(0.4.1)とfaradayのoauthモジュールとで異なってしまい認証がうまくいかないためfaraday側のbody部分解析をoauth(0.4.1)相当に合わせている
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

      # Override Faraday::Utils#include_body_params?
      # oauth(0.4.1)でpostの場合のみbodyをsignature-base-stringに含めているので
      def include_body_params?(env)
        # see RFC 5489, section 3.4.1.3.1 for details
        env[:method] == :post && (!(type = env[:request_headers][CONTENT_TYPE]) or type == TYPE_URLENCODED)
      end
    end
  end
end

