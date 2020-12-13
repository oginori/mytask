class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  enum priority:[:high, :medium, :low]

  validates :name, presence: true
  validates :description, presence: true

  scope :search_by_name, -> (search) do
    where('Tasks.name LIKE ?', "%#{search}%")
  end

  scope :search_by_status, -> (search) do
    where(status: "#{search}")
  end

  scope :search_by_label, -> (search) do
    joins(:labels).where(labels: { id: "#{search}"})
  end
end
