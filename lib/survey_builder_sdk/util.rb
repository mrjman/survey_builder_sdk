require 'cgi'
require 'time'

module SurveyBuilder
  module Util
    class << self
      def array_wrap(object)
        if object.nil?
          []
        elsif object.respond_to?(:to_ary)
          object.to_ary || [object]
        else
          [object]
        end
      end

      def to_query(hash)
        query = hash.map do |key, value|
          encoded_value = CGI.escape(value.to_s)
          "#{key}=#{encoded_value}" unless encoded_value.empty?
        end.compact

        query.sort!.join('&')
      end

      def str_to_time(value)
        Time.parse(value) if value
      end
    end
  end
end
