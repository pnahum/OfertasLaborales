class Offer < ApplicationRecord
	has_many :posts, dependent: :destroy
end
