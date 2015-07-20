State.destroy_all
Brewery.destroy_all

def state_names
  ["alabama", "alaska", "arizona", "arkansas", "california", "colorado", "connecticut", "delaware", "florida", "georgia", "hawaii", "idaho", "illinois", "indiana", "iowa", "kansas", "kentucky", "louisiana", "maine", "maryland", "massachusetts", "michigan", "minnesota", "mississippi", "missouri", "montana", "nebraska", "nevada", "new+hampshire", "new+jersey", "new+mexico", "new+york", "north+carolina", "north+dakota", "ohio", "oklahoma", "oregon", "pennsylvania", "rhode+island", "south+carolina", "south+dakota", "tennessee", "texas", "utah", "vermont", "virginia", "washington", "west+virginia", "wisconsin", "wyoming"]
end

state_names.each do |state|
  State.new(name: state).save
end

@key = "dd604aa40606566d3f9fcba2c8ff7d8c"

def load_db_json(input)
  JSON.load(RestClient.get("http://api.brewerydb.com/v2/" + input){|response, request, result| response })
end

def state_locations(state)
  load_db_json("locations?region=#{state}&key=#{@key}")
end

def number_of_json_pages(state)
  state_locations(state)["numberOfPages"]
end

def iterate_through_json(state)  #should be called: make all breweries in a state
  (1..number_of_json_pages(state)).each do |number|
    load_db_json("locations?region=#{state}&key=#{@key}&p=#{number}")["data"].each do |hash|
      @state = State.find_by(name: state)
      
      @state.breweries.build(name: hash["brewery"]["name"], db_code: hash["brewery"]["id"])
      @state.save
    end
  end
end

# state_names[0..3].each do |state|
#   iterate_through_json(state)
# end

iterate_through_json(state_names[1])

def all_beers_from_brewery(brewery)
  load_db_json("brewery/#{brewery.db_code}/beers?key=#{@key}")["data"]
end

@state = State.find_by(name: "alaska")


@state.breweries.each do |brewery|
  if !all_beers_from_brewery(brewery).nil?
    all_beers_from_brewery(brewery).each do |hash|
      brewery.beers.build(name: hash["name"], db_code: hash["id"], abv: hash["abv"], ibu: hash["ibu"], description: hash["description"])
      brewery.save
    end
  else
  end
end



#all_beers_from_brewery(brewery).each do |hash|
  #@brewery = brewery
  #@brewery.beers.build(name: hash["name"], db_code: hash["id"], abv: hash["abv"], ibu: hash["ibu"], description: hash["description"])
#end