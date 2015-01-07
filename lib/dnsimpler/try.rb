unless Hash.instance_methods.include? :try
  class Hash

    def try(key)
      return send("[]", key)
    end

  end
end

unless NilClass.instance_methods.include? :try
  class NilClass

    def try(key); nil; end

  end
end
