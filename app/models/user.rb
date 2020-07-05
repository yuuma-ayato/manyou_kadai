class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  before_destroy :do_not_destroy_last_admin
  has_many :tasks, dependent: :destroy

  private
  def do_not_destroy_last_admin
    if self.admin? && User.where(admin: :true).count == 1
      throw :abort
    end
  end

end
