class Concert < ApplicationRecord

  belongs_to :festival
  belongs_to :artist
  has_many :events

  scope :of_the_day, -> (datetime) { where("? <= start_time AND start_time < ?", datetime, datetime + 1.day)}

  include AlgoliaSearch

  algoliasearch do
    attributesToIndex ['stage']
    customRanking ['artist_id']
    add_attribute :artist_name do
      artist_name
    end
  end

  def artist_name
    self.artist.name
  end

end
