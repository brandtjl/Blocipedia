class User < ApplicationRecord
  enum role: [:user, :admin]
  enum account_type: [:free, :premium]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :wikis, dependent: :destroy
end
