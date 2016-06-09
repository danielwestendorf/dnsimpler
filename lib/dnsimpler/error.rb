module DNSimpler
  class Error < StandardError
    attr_reader :code, :body, :response

    def initialize(code, body, response)
      @code = code
      @body = body
      @response = response
    end

  end
end
