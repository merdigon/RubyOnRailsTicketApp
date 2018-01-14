class Ticket < ApplicationRecord
    validates :name, :presence => true, :length => { :minimum => 6 }
    validates :email_address, :presence => true
    validates :price, :presence => true
    validates :phone, :presence => true
    belongs_to :event
end
