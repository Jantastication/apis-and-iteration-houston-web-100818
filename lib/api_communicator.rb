require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  character_hash = response_hash["results"].find do |character_info|
    character_info["name"].downcase == character.downcase
  end

  final_array = []
  character_hash["films"].each do |film_url|
    response_string = RestClient.get(film_url)
    response_hash = JSON.parse(response_string)
    final_array << response_hash 
  end 
  
  final_array
end  

def print_movies(films_array)
  films_array.each do |films_info|
    puts films_info["title"]
  end 
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end
 

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
