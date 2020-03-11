class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  # Redirects home page to the recipes page
  get '/' do
    redirect '/recipes'
  end

  # Read action - displays all recipes
  get '/recipes' do
    @recipes = Recipe.all 
    erb :index
  end

  # Create action - takes us to the form to create a new recipe
  get '/recipes/new' do
    erb :new
  end

  # Create action - creates the new recipe instance on submission of form
  # Takes us to that recipe and displays it
  post '/recipes' do
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  # Delete action - deletes a single recipe
  delete '/recipes/:id' do
    recipe = Recipe.find(params["id"])
    recipe.destroy
    redirect '/recipes'
  end

  # Display recipe
  get '/recipes/:id' do
    @recipe = Recipe.find(params["id"])
    erb :show
  end

  # Provides form to update
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params["id"])
    erb :edit
  end

  # Update action that updates the instance then shows it
  patch '/recipes/:id' do
    recipe = Recipe.find(params["id"])
    params.delete("_method")
    recipe.update(params)
    redirect "/recipes/#{recipe.id}"
  end

end
