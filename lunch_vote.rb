require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, 'mysql://lunch_vote:Shoot7bo@localhost/lunch_vote')

class Locations
  include DataMapper::Resource

  property :id, Serial #Primary Key
  property :name, String, :length => 60
  # Broken -- HOW TO DO THIS IN DM?!?
  #property :registered, DateTime, :default => lambda{ |p,s| DateTime.now}
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# Automatically create the table
Locations.auto_upgrade!

get '/' do
  @title = 'Welcome to the Lunch Vote!'
  erb :index
end

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  erb :cast
end

get '/results' do
  @votes = { 'HAM' => 7, 'PIZ' => 5, 'CUR' => 3 }
  erb :results
end

Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}
