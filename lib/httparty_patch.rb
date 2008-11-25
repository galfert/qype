require 'oauth/consumer'
require 'oauth/client/helper'

module HTTParty
  class Request
    private
      def oauth_header(request, oauth_config, token = nil, options = {})
        consumer = OAuth::Consumer.new(oauth_config[:key], oauth_config[:secret])
        options = { :request_uri => uri,
                    :consumer => consumer,
                    :token => token,
                    :scheme => 'header',
                    :signature_method => oauth_config[:method],
                    :nonce => nil,
                    :timestamp => nil }.merge(options)

        OAuth::Client::Helper.new(request, options).header
      end

      def headers_including_oauth(request)
        if options[:oauth]
          { 'Authorization' => oauth_header(request, options[:oauth]) }.merge(options[:headers] || {})
        else
          options[:headers]
        end
      end

      def get_response(uri) #:nodoc:
        request = http_method.new(uri.request_uri)
        request.body = options[:body].is_a?(Hash) ? options[:body].to_query : options[:body] unless options[:body].blank?
        request.initialize_http_header headers_including_oauth(request)
        request.basic_auth(options[:basic_auth][:username], options[:basic_auth][:password]) if options[:basic_auth]
        response = http(uri).request(request)
        options[:format] ||= format_from_mimetype(response['content-type'])
        response
      end
  end
end