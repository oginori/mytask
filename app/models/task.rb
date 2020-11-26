class Task < ApplicationRecord
  enum priority:[:high, :medium, :low]
  
  validates :name, presence: true
  validates :description, presence: true

  scope :search_by_name, -> (search) do
    where('name LIKE ?', "%#{search}%")
  end

  scope :search_by_status, -> (search) do
    where(status: "#{search}")
  end
end
