# -*- coding: utf-8 -*-
module Cliskip2
  class Base
    attr_accessor :attrs

    # Define methods that retrieve the value from an initialized instance variable Hash, using the attribute as a key
    #
    # @overload self.lazy_attr_reader(attr)
    #   @param attr [Symbol]
    # @overload self.lazy_attr_reader(attrs)
    #   @param attrs [Array<Symbol>]
    def self.lazy_attr_reader(*attrs)
      attrs.each do |attribute|
        class_eval do
          define_method attribute do
            @attrs[attribute.to_s]
          end
        end
      end
    end

    # Initializes a new Base object
    #
    # @param attrs [Hash]
    # @return [Twitter::Base]
    def initialize(attrs={})
      @attrs = attrs.dup
    end
  end
end
