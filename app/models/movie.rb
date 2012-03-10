class Movie < ActiveRecord::Base
  def self.getRatings()
    return ['G','PG','PG-13','R']
  end
end
