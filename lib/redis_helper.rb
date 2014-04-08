require 'oj'

class RedisHelper
  def initialize(opts = {})
    @client = Redis.new # Uses ENV['REDIS_URL'] by default
  end

  def fetch(key, opts = {})
    result = nil

    begin
      result = @client.get(key)
      if result
        result = Oj.load(result)
      else
        result = yield
        unless result.nil?
          @client.set(key, Oj.dump(result))
          @client.expire(key, opts[:expire]) if opts.has_key?(:expire)
        end
      end
    rescue
      # Just try and return the value without touching the cache
      result = yield
    end

    result
  end
end
