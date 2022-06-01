class Savedpost < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarklist
  belongs_to :micropost
end
