module DNSimpler
  class Error < StandardError
    attr_reader :code, :body, :response

    def initialize(object)
      @object = object
    end

  end
end
