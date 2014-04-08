require 'redis'
require 'oj'

configure do
  REDIS = RedisHelper.new
end

# Force JSON for all endpoints
before do
  headers 'Content-Type' => 'application/json; charset=utf-8'
end

get '/check/:host' do
  key = params[:host] || 'nohost'
  force = params.has_key?('force')
  h = REDIS.fetch(key, expire: 3600, force: force) do
    unless params.has_key?('host')
      status = 'error'
      result = 'Host parameter is missing'
    else
      result = Heartbleeder.check(params[:host])
      status = ['INSECURE', 'SECURE'].any? { |i| result.include?(i) } ? 'success' : 'error'
    end

    { status: status, data: result }
  end

  Oj.dump(h)
end
