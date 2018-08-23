class ToysController < Sinatra::Base
  # sets the root as the parent-directry of the current file
 set :root, File.join(File.dirname(__FILE__),'..')
 # Sets the view directory correctly
 set :views, Proc.new {File.join(root,'views')}

  configure :development do
    register Sinatra::Reloader
  end
  $toys = [{
    id:0,
    title:'Toy 1: Despicable Me',
    toy_body: 'Despicable Me 3'
    },
    {
    id:1,
    title:'Toy 2: Transformers',
    toy_body: 'Bumblebee'
    },
    {
    id:2,
    title:'Toy 3:Pokémon',
    toy_body: 'gotta get them all'
  },
    {
    id: 3,
    title:'Toy 4: Superman',
    toy_body: 'Justice League'
    }]

  get "/" do
    @title = "List of Toys"
    @toy = $toys
    erb :'toys/index'
  end

  get '/new' do
    @title = "New"
    @toy = {
      id:'',
      title: '',
      toy_body: ''
    }
    erb :'toys/new'
  end

  get '/:id' do
    id = params[:id].to_i
    @toy = $toys[id]
    erb :'toys/show'

  end
  get '/:id/edit' do
    @title = 'Edit'
    id = params[:id].to_i
    @toy = $toys[id]

    erb :'toys/edit'

  end

  post '/' do
    new_toy = {
      id: $toys.length,
      title: params[:title],
      toy_body: params[:toy_body]
    }
    $toys.push(new_toy)
    redirect '/'
  end

  put "/:id" do
    id = params[:id].to_i
    toy = $toys[id]
    toy[:title] = params[:title]
    toy[:toy_body] = params[:toy_body]

    $toys[id] = toy

    redirect '/'
  end

  delete '/:id' do
    id = params[:id].to_i
    $toys.delete_at(id)
    redirect '/'
  end

end
