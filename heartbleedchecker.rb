require 'oj'

# Force JSON for all endpoints
before do
  headers 'Content-Type' => 'application/json; charset=utf-8'
end

get '/check/:host' do
  unless params.has_key?(:host) or params.has_key?('host')
    h = { status: 'error', data: 'Host parameter is missing' }
  else
    result = Heartbleeder.check(params[:host])
    h = { status: 'success', data: result }
  end

  Oj.dump(h)
end
