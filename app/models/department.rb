class Department < ApplicationRecord
  belongs_to :faculty
  has_many :groups  

  validates :name, presence: true, length: {maximum: 255}
  validates :faculty_id, presence: true
end
