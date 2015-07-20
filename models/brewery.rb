class Brewery < ActiveRecord::Base
  belongs_to :state
  has_many :beers
end