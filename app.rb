require_relative 'config/environment'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  get '/' do

    erb :index
  end

  post '/' do
    @state = State.find_by(name: params[:state_name])
    
    redirect "/#{@state.name}"
  end

  get '/:state_name' do
    @state = State.find_by(name: params[:state_name])
    @brewery = @state.random_brewery
    @beer = @brewery.beers.sample
    
    erb :test
  end

end

