class Progress < ApplicationRecord
  belongs_to :estimate
  belongs_to :admin
end
