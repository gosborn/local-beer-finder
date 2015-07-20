class State < ActiveRecord::Base
  has_many :breweries
  has_many :beers, through: :breweries

  attr_accessor :key, :brewery, :beer, :all_beers

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

end