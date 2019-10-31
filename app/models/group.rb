class Group < ApplicationRecord
  belongs_to :department
  
  validates :name, presence: true, length: {maximum: 255}
  validates :number, presence: true
  validates :department_id, presence: true


  def fullname
    "#{self.name}#{self.number.to_s}"
  end
end
