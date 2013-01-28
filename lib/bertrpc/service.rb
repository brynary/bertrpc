module BERTRPC
  class Service
    attr_accessor :host, :port, :timeout

    def initialize(host, port, timeout = nil)
      @host = host
      @port = port
      @timeout = timeout
    end

    def call(options = nil)
      verify_options(options)
      Request.new(self, :call, options)
    end

    def cast(options = nil)
      verify_options(options)
      Request.new(self, :cast, options)
    end

    # private

    def verify_options(options)
      if options
        if cache = options[:cache]
          unless cache[0] == :validation && cache[1].is_a?(String)
            raise InvalidOption.new("Valid :cache args are [:validation, String]")
          end
        end

        if priority = options[:priority]
          unless [:high, :low].include?(priority)
            raise InvalidOption.new("Valid :priority values are :low or :high")
          end
        end
      end
    end
  end
end
