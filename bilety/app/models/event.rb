class Event < ApplicationRecord
    validates :artist, presence: true
    validates :event_date, presence: true
    validates :price_low, numericality: true, presence: true
    validates :price_high, numericality: true, presence: true
end
