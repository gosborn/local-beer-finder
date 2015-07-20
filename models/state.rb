class State < ActiveRecord::Base
  has_many :breweries
  has_many :beers, through: :breweries

  attr_accessor :key, :brewery, :beer, :all_beers

  # def initialize
  #   @key = "dd604aa40606566d3f9fcba2c8ff7d8c"
  #   @brewery = random_brewery_page
  #   @all_beers = all_beers_from_brewery
  #   @beer = beer
  # end

  def formatted_name
    name.split("+").collect{|word| word.capitalize}.join(" ")
  end

  def random_brewery
    brewery = self.breweries.sample
    if brewery.beers.empty?
      random_brewery
    else
      return brewery
    end
  end

  # def load_db_json(input)
  #   JSON.load(RestClient.get("http://api.brewerydb.com/v2/" + input))
  # end

  # def state_locations
  #   load_db_json("locations?region=#{@name}&key=#{@key}")
  # end

  # def number_of_json_pages #this could go into a database, this is call number 1 to db
  #   state_locations["numberOfPages"]
  # end

  # def random_page
  #   rand(number_of_json_pages)
  # end

  # def random_brewery_page #this is call number 2 to db
  #   load_db_json("locations?region=#{@name}&key=#{@key}&p=#{random_page}")["data"].sample  
  # end

  # def brewery_name
  #   @brewery["brewery"]["name"]
  # end

  # def brewery_id
  #   @brewery["brewery"]["id"]
  # end

  # def all_beers_from_brewery(brewery)
  #   load_db_json("brewery/#{brewery.db_code}/beers?key=#{@key}")["data"]
  # end

  # def beer
  #   if @all_beers.nil?
  #     "beer"
  #   else
  #     @all_beers.sample
  #   end
  # end

  # def beer_name
  #   if @beer == "beer"
  #     "beer"
  #   else
  #     @beer["name"]
  #   end
  # end

  # def beer_description
  #   if @beer == "beer" || @beer["description"].nil?
  #     nil
  #   else
  #     @beer["description"]
  #   end
  # end

  # def beer_abv
  #   if @beer == "beer" || @beer["abv"].nil?
  #     nil
  #   else
  #     @beer["abv"]
  #   end
  # end




end