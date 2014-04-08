require 'redis'
require 'oj'

configure :production do
  require 'newrelic_rpm'
end

configure do
  REDIS = RedisHelper.new
end

# Force JSON for all endpoints
before do
  headers 'Access-Control-Allow-Origin' => '*'
  headers 'Access-Control-Allow-Methods' => 'GET, OPTIONS, HEAD'
  headers 'Access-Control-Allow-Headers' => 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type'

  # Intercept CORS OPTIONS request here as sinatra does not
  # have an `options` verb.
  halt 200 if request.request_method == 'OPTIONS'

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
