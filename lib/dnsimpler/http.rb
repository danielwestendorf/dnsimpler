require 'httparty'

module DNSimpler
  class HTTP
    include HTTParty

    def self.base_options
      opts = {
        base_uri: DNSimpler.base_uri,
        format: :json,
        headers: {
          'Accept' => 'application/json',
          'User-Agent' => "dnsimpler/#{DNSimpler::VERSION}",
          'X-DNSimple-Token' => "#{DNSimpler.username}:#{DNSimpler.token}"
        }
      }

      unless DNSimpler.http_proxy.nil?
        proxy = DNSimpler.http_proxy
        opts[:http_proxy_addr] = proxy[:addr]
        opts[:http_proxy_port] = proxy[:port]
        opts[:http_proxy_user] = proxy[:user]
        opts[:http_proxy_pass] = proxy[:pass]
      end

      opts
    end

    %w[get post head delete patch put].each do |method|
      class_eval <<-RUBY_EVAL

        def self.#{method}(path, options = {}, &blk)
          instance_opts = self.base_options.merge(options)
          response = super(path, instance_opts, &blk)

          return OpenStruct.new(code: response.code, body: response.parsed_response)
        end

      RUBY_EVAL
    end

  end
end