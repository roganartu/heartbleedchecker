require 'oj'

# Force JSON for all endpoints
before do
  headers 'Content-Type' => 'application/json; charset=utf-8'
end

get '/check/:host' do
  unless params.has_key?(:host) or params.has_key?('host')
    status = 'error'
    result = 'Host parameter is missing'
  else
    result = Heartbleeder.check(params[:host])
    status = ['INSECURE', 'SECURE'].any? { |i| result.include?(i) } ? 'success' : 'error'
  end

  Oj.dump({ status: status, data: result })
end
