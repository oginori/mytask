class User < ApplicationRecord
  before_destroy :ensure_admin_delete
  has_many :tasks, dependent: :destroy

  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  private

  def ensure_admin_delete
     if User.where(admin: true).count == 1 && self.admin == true
       throw(:abort)
     end
  end
end
