class Faculty < ApplicationRecord
  has_many :departments
  
  validates :name, presence: true, length: {maximum: 255}
end
