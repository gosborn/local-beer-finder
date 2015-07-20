class BreweryDBParser

  #most of BreweryDBParser lives in the seeds.rb file. Need to refactor that code and bring into this file

  def initialize
    @key = "dd604aa40606566d3f9fcba2c8ff7d8c"
  end

  def state_names
    ["alabama", "alaska", "arizona", "arkansas", "california", "colorado", "connecticut", "delaware", "florida", "georgia", "hawaii", "idaho", "illinois", "indiana", "iowa", "kansas", "kentucky", "louisiana", "maine", "maryland", "massachusetts", "michigan", "minnesota", "mississippi", "missouri", "montana", "nebraska", "nevada", "new+hampshire", "new+jersey", "new+mexico", "new+york", "north+carolina", "north+dakota", "ohio", "oklahoma", "oregon", "pennsylvania", "rhode+island", "south+carolina", "south+dakota", "tennessee", "texas", "utah", "vermont", "virginia", "washington", "west+virginia", "wisconsin", "wyoming"]
  end

  def load_db_json(input)
    JSON.load(RestClient.get("http://api.brewerydb.com/v2/" + input))
  end

  def state_locations(state)
    load_db_json("locations?region=#{state}&key=#{@key}")
  end

  #so like state_locations(state_names[0]) to get all from alabama

  def number_of_json_pages(state) #this will return an integer representing number of pages, use this to refactor
    state_locations(state)["numberOfPages"]
  end

#can modify this to iterate through json, I think this needs to take state, like super state_locations, find ALL breweries, it works!
#now if you create a brewery class, you can make a new Brewery with each parameter
#the brewery can have a class method that will return random when you input a state_id, some arel nonsense

#State.find_or_create_by(:name => state)


  def iterate_through_json(state)  #should be called: make all breweries in a state
    (1..number_of_json_pages(state)).collect do |number|
      load_db_json("locations?region=#{state}&key=#{@key}&p=#{number}")["data"].collect do |hash|
        hash["id"] # eventually Brewery.build(:name => hash["brewery"]["name"], :state_id => :state_id)
      end
    end.flatten
  end

  def name_iterate_through_json(state) 
    (1..state_locations(state)["numberOfPages"]).collect do |number|
      load_db_json("locations?region=#{state}&key=#{@key}&p=#{number}")["data"].collect do |hash|
        hash["brewery"]["name"]
      end
    end.flatten
  end


  # think this isn't important anymore
  # def find_all_breweries(json)
  #   json.state_locations["data"].each do |hash|
  #       hash["name"]
  #   end
  # end

  def all_breweries_in_us
    state_names.collect do |state|
      name_iterate_through_json(state)
    end
  end






end