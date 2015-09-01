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

      $stdout.puts "Base Options: #{opts}" if DNSimpler.debug

      return opts
    end

    %w[get post head delete patch put].each do |method|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__

        def self.#{method}(path, opts = {}, &blk)
          opts = {body: opts}
          opts.merge!(self.base_options)

          req = super path, opts, &blk

          if (200...400).include? req.code
            response = OpenStruct.new(code: req.code, body: req.parsed_response)

            if DNSimpler.debug
              response.request = req

              $stdout.puts "Request Options: #{opts.inspect}" 
            end

            return response
          else
            raise Error.new(req.code, req.parsed_response, req)
          end
        end

      RUBY_EVAL
    end

  end
end
