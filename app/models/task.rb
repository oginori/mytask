class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true

  scope :search_by_name, -> (search) do
    where('name LIKE ?', "%#{search}%")
  end

  scope :search_by_status, -> (search) do
    where(status: "#{search}")
  end
end
