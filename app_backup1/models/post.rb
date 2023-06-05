class Post < ApplicationRecord
  belongs_to :user
  belongs_to :offer
  validates_uniqueness_of :user_id, scope: :offer_id
end
