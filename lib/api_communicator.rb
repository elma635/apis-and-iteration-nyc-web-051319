require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  string =  response_string.body
  response_hash = JSON.parse(string)
  #vv for user's to be able to match up char with films

  film_data = []
  ary_of_results = response_hash["results"]
  ary_of_results.each do |results|
    ary_of_films = results["films"]
      ary_of_films.map do |url|
        urls = RestClient.get(url)
        z = urls.body
        film_data << JSON.parse(z)
        #binding.pry
      end

  end

  #urls

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`

  # , make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film




  # this collection will be the argument given to `print_movies`
  print_movies(film_data)
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
    pretty_output = []
    # binding.pry
    count = 1
     films.map do |film|
      if count < film.size
        pretty_output <<  "#{film["title"]}"
        count +=1
      else
        puts "end"
     end
     puts pretty_output
     #puts film
     ##{film["title"]}{film["episode_id"]}
    #puts so that we can see it -- map normally just returns for comp to see
  # some iteration magic and puts out the movies in a nice list
  #binding.pry
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
